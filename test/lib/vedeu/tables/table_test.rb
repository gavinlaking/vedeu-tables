require 'test_helper'

module Vedeu

  module Tables

    describe Table do

      let(:described)  { Vedeu::Tables::Table }
      let(:instance)   { described.new(attributes) }
      let(:attributes) {
        {
          caption:  caption,
          data:     data,
          headings: headings,
          title:    title,
        }
      }
      let(:caption)  { 'People living in my house.' }
      let(:data)     {
        [
          {
            name:     'Gav',
            age:      37,
            gender:   'Male',
            location: 'Manchester, UK',
          },
          {
            name:     'Angel',
            age:      32,
            gender:   'Female',
            location: 'Manchester, UK',
          },
        ]
      }
      let(:headings) {
        {
          name:     'Name',
          age:      'Age',
          gender:   'Gender',
          location: 'Location',
        }
      }
      let(:title)    { 'My Cool Table' }

      before do
        Vedeu.stubs(:width).returns(40)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@caption').must_equal(caption) }
        it { instance.instance_variable_get('@data').must_equal(data) }
        it { instance.instance_variable_get('@headings').must_equal(headings) }
        it { instance.instance_variable_get('@title').must_equal(title) }
      end

      describe '.build' do
        subject { described.build(attributes) }

        it { subject.must_be_instance_of(described) }
      end

      describe '#render' do
        subject { instance.render }

        context 'when there is no title or caption' do
          let(:title)   {}
          let(:caption) {}

          it { subject.must_equal(
            "+--------------------------------------+\n" \
            "+--------------------------------------+"
          )}
        end

        context 'when there is a title but no caption' do
          let(:caption) {}

          it { subject.must_equal(
            "+--------------------------------------+\n" \
            "|            My Cool Table             |\n" \
            "+--------------------------------------+") }

          context 'and the title is longer than the available space' do
            let(:title) { 'The Superfunkycalifragisexy Guestlist' }

            it { subject.must_equal(
              "+--------------------------------------+\n" \
              "| The Superfunkycalifragisexy Guestlis |\n" \
              "+--------------------------------------+") }
          end
        end

        context 'when there is a title and a caption' do
          it { subject.must_equal(
            "+--------------------------------------+\n" \
            "|            My Cool Table             |\n" \
            "|      People living in my house.      |\n" \
            "+--------------------------------------+") }

          context 'and the caption is longer than the available space' do
            let(:caption) { 'A freezer burn compared to cool- too sexy!' }

            it { subject.must_equal(
              "+--------------------------------------+\n" \
              "|            My Cool Table             |\n" \
              "| A freezer burn compared to cool- too |\n" \
              "+--------------------------------------+") }
          end
        end
      end

      describe 'private methods' do
        describe '#column_width' do
          subject { instance.column_width }

          context 'when there are no headings or data' do
            let(:headings) {}
            let(:data)     {}

            it { subject.must_equal(38) }
          end

          context 'when there are no headings but there is data' do
            let(:headings) {}

            it { subject.must_equal(8) }
          end

          context 'when there are headings' do
            it { subject.must_equal(8) }
          end
        end

        describe '#columns' do
          subject { instance.columns }

          context 'when there are no headings or data' do
            let(:headings) {}
            let(:data)     {}

            it { subject.must_equal(1) }
          end

          context 'when there are no headings but there is data' do
            let(:headings) {}

            it { subject.must_equal(4) }
          end

          context 'when there are headings' do
            it { subject.must_equal(4) }
          end
        end
      end

    end # Table

  end # Tables

end # Vedeu
