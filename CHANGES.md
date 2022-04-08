### dev

### 0.5.1 / 2022-04-08

* Biggs::Extractor: small refactorings + don't delete options

### 0.5.0 / 2022-04-08

* Refactored Biggs::Concern to use Biggs::Extractor
* Removed activerecord dependency and use only activesupport instead
* Renamed Biggs::ActiveRecordAdapter to Biggs::Concern, include with 'include Biggs'
* Optimization: Added Biggs::Formatter::FIELDS_WO_COUNTRY
* Moved Biggs.formats and Biggs.country_names to Constants Biggs::FORMATS & Biggs::COUNTRY_NAMES

### 0.4.0 / 2022-04-08

* [BREAKING]: Do not include to ActiveRecord::Base per default, use 'include Biggs::ActiveRecordAdapter' in your classes
* Allow multiple biggs methods per class

### 0.3.3 / 2013-05-06

* Added support for Rails 4 (by [mdemare](https://github.com/mdemare))

### 0.3.2 / 2013-02-19

* Fixed warning in Biggs::Format

### 0.3.1 / 2012-08-02

* Fixed LI format

### 0.3.0 / 2012-06-15

* Added country names for countries with default/unknown address format
* Simplified inclusion of Biggs::ActiveRecordAdapter
* Changed doc-format from textile to markdown

### 0.2.2 / 2012-02-06

* Compatibility with ActiveRecord/Rails 3.2

### 0.2.1 / 2011-11-09

* Fixed gemspec activerecord dependency

### 0.2.0 / 2011-10-12

* Added Bundler & removed jewler
* Fixed Specs
* Added NC (New Caledonia)

### 0.1.5 / 2010-11-24

* Fixed address format for Norway
* Added TH (Thailand)

### 0.1.4 / 2009-5-21

* Fixed Specs

### 0.1.3 / 2009-3-6

* Correct japanese address format. (by [hiroshi](https://github.com/hiroshi))
* Fixed docs for current API. (by [hiroshi](https://github.com/hiroshi))

### 0.1.2 / 2009-3-4

* Values can now be specified by an array of symbols.

### 0.1.1 / 2009-3-3

* Refactored activerecord-adapter to include only basic setup method in ActiveRecord:Base

### 0.1.0 / 2009-3-3

* Allow Procs as params in biggs-activerecord-setup.
* Cleanup

