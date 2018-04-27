<weapons>
<select ref="input">
	<option each={ weaponList }>{ name }</option>
</select>
<button onclick={ add }>Add</button>
<table class="table table-sm table-bordered">
	<thead>
		<th>Name</th>
		<th>Range</th>
		<th>Clip</th>
		<th>Damage</th>
		<th>Pen</th>
		<th>Single</th>
		<th>Semi-Auto</th>
		<th>Full Auto</th>
		<th>Ammo</th>
		<th></th>
	</thead>
	<tbody>
		<tr each={ activeWeapons }>
			<td>{ name }</td>
			<td>{ range }</td>
			<td>{ clip }</td>
			<td>{ damage }</td>
			<td>{ pen }</td>
			<td data-mode="single" onclick={ fire }>{single || '-'}</td>
			<td data-mode="semi" onclick={ fire }>{semi || '-'}</td>
			<td data-mode="full" onclick={ fire }>{full || '-'}</td>
			<td>{ ammo }</td>
			<td class="reload" onclick={ reload }>reload</td>
		</tr>
	</tbody>
</table>

<style type="text/css">
	td {
		cursor: pointer;
	}
	.reload {
		text-transform: uppercase;
		text-align: center;
	}
</style>

<script>
	this.activeWeapons = [];
	this.weaponList = opts.weaponList || [];

	add() {
		weapon = this.weaponList.find(w => w.name == this.refs.input.value);
		weapon.ammo = weapon.clip;
		weapon.reload = function() {
			this.ammo = this.clip;
		}.bind(weapon)
		weapon.fire = function(e) {
			let mode = e.target.dataset.mode;
			let amount = Number(this[mode])
			if (this.ammo < amount) {
				alert(`not enough ammo, max hits = ${this.ammo}`);
				this.ammo = 0;
			} else {
				this.ammo -= amount;
			}
		}.bind(weapon)
		this.activeWeapons.push(weapon);
	}
	this.on('mount', function() {
		this.add();
		this.update();
	})
</script>
</weapons>
