require 'test_helper'

module Vedeu

  module Tables

    describe Table do

      let(:described)  { Vedeu::Tables::Table }
      let(:instance)   { described.new(attributes, options) }
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
            location: 'Manchester',
          },
          {
            name:     'Angel',
            age:      32,
            gender:   'Female',
            location: 'Manchester',
          },
        ]
      }
      let(:headings) {
        [
          'Name',
          'Age',
          'Gender',
          'Location',
        ]
      }
      let(:title)    { 'My Cool Table' }
      let(:options)  {
        {}
      }

      before do
        Vedeu.stubs(:width).returns(40)
      end

      describe '#initialize' do
        it { instance.must_be_instance_of(described) }
        it { instance.instance_variable_get('@caption').must_equal(caption) }
        it { instance.instance_variable_get('@data').must_equal(data) }
        it { instance.instance_variable_get('@headings').must_equal(headings) }
        it { instance.instance_variable_get('@title').must_equal(title) }
        it { instance.instance_variable_get('@options').must_equal(options) }
      end

      describe '.build' do
        subject { described.build(attributes) }

        it { subject.must_be_instance_of(described) }
      end

      describe '#render' do
        subject { instance.render }

        context 'when there is no title, headings, caption or data' do
          let(:title)    {}
          let(:headings) {}
          let(:caption)  {}
          let(:data)     {}

          it { subject.must_equal(
            "+--------------------------------------+\n" \
            "+--------------------------------------+"
          )}
        end

        context 'when there is a title but no headings, caption or data' do
          let(:headings) {}
          let(:caption)  {}
          let(:data)     {}

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

        context 'when there is a title, a caption but no headings or data' do
          let(:headings) {}
          let(:data)     {}

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

        context 'when there are headings' do
          it { subject.must_equal(
            "+--------------------------------------+\n" \
            "|            My Cool Table             |\n" \
            "+--------------------------------------+\n" \
            "+--------------------------------------+\n" \
            "|      People living in my house.      |\n" \
            "+--------------------------------------+") }
        end

        # context 'when there is data' do
        #   it { subject.must_equal(
        #     "+--------------------------------------+\n" \
        #     "|            My Cool Table             |\n" \
        #     "| Gav      | 37       | Male     | Manchester | \n" \
        #     "| Angel    | 32       | Female   | Manchester | \n" \
        #     "|      People living in my house.      |\n" \
        #     "+--------------------------------------+") }
        # end
      end

      describe 'private methods' do
        describe '#column_width' do
          subject { instance.column_width }

          context 'when there are no headings or data' do
            let(:headings) {}
            let(:data)     {}

            it { subject.must_equal(39) }
          end

          context 'when there are no headings but there is data' do
            let(:headings) {}

            it { subject.must_equal(9) }
          end

          context 'when there are headings' do
            it { subject.must_equal(9) }
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

        describe '#' do
          subject { instance.total_width }

          it { subject.must_equal(36) }
        end
      end

    end # Table

  end # Tables

end # Vedeu
