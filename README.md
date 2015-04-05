# Angular Bootstrap Form Group Directive

Form group directive for AngularJs. This directive integrate Bootstrap's form and Angularjs for auto display validation message and reduce redundanc HTML.


### Demos

1. `git clone https://github.com/lawrence0819/angular-bootstrap-form-group.git`
2. cd angular-bootstrap-form-group
3. cd demo
4. open html file

### Getting Started

```
<script type='text/javascript' src='angular.min.js'></script>
<script type='text/javascript' src='bootstrap-form-group.min.js'></script>
```

1. Create a form element (must assign name to form element)
2. Create a form-group directive inside form element
3. Create a input element inside form-group directive (must assign name to input element)

```
<form name="form" role="form" novalidate>
  <div form-group label="Email*">
    <input id="email" type="text" ng-model="user.email" name="email" class="form-control"
      ng-minlength="10"
      ng-maxlength="100"
      ng-pattern="/^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$/" 
      ng-em-required="Please enter email address"
      ng-em-minlength="At least enter 10 characters"
      ng-em-maxlength="Cannot over 100 characters"
      ng-em-pattern="Please input email format"
      required/>
  </div>
</form>
```

ng-em-* is a validation message attribute for directive display correspondence message when validation failed.


### Development

```
npm install

bower install
```
