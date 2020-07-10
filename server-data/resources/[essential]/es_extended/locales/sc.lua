Locales['sc'] = {
  -- Inventory
  ['inventory'] = '库存 %s / %s',
  ['use'] = '使用',
  ['give'] = '赠送',
  ['remove'] = '丢弃',
  ['return'] = '返回',
  ['give_to'] = '赠给',
  ['amount'] = '数量',
  ['giveammo'] = '赠送弹药',
  ['amountammo'] = '弹药量',
  ['noammo'] = '你没有足够的弹药！',
  ['gave_item'] = '你把~y~%sx~s~~b~%s~s~赠给了~y~%s~s~',
  ['received_item'] = '你收到~y~%sx~s~~b~%s~s~，来自~b~%s~s~',
  ['gave_weapon'] = '你把~b~%s~s~赠给了~y~%s~s~',
  ['gave_weapon_ammo'] = '你把~o~%sx~s~~b~%s~s~ %s~s~赠给了~y~%s~s~',
  ['gave_weapon_withammo'] = '你把~b~%s~s~和~o~%sx~s~ %s~s~赠给了~y~%s~s~',
  ['gave_weapon_hasalready'] = '~y~%s~s~已经拥有~y~%s~s~',
  ['gave_weapon_noweapon'] = '~y~%s~s~没有那个武器',
  ['received_weapon'] = '你收到了~b~%s~s~，来自~b~%s~s~',
  ['received_weapon_ammo'] = '你收到了~o~%sx~s~ %s~s~(~b~%s~s~)，来自~b~%s~s~',
  ['received_weapon_withammo'] = '你收到了~b~%s~s~和~o~%sx~s~ %s~s~，来自~b~%s~s~',
  ['received_weapon_hasalready'] = '~b~%s~s~试图给你~y~%s~s~，但你已经拥有了',
  ['received_weapon_noweapon'] = '~b~%s~s~试图给你~y~%s~s~弹药，但你没有那个武器',
  ['gave_account_money'] = '你将 ~g~$%s~s~ (%s) 给予 ~y~%s~s~',
  ['received_account_money'] = '你收到了~g~$%s~s~ (%s) 来自 ~b~%s~s~',
  ['amount_invalid'] = '无效数量',
  ['players_nearby'] = '附近没有市民',
  ['ex_inv_lim'] = '操作失败, 超过~y~%s~s~的物品栏限制',
  ['imp_invalid_quantity'] = '操作失败，无效数量',
  ['imp_invalid_amount'] = '操作失败，无效金额',
  ['threw_standard'] = '你丢弃了~y~%sx~s~~b~%s~s~',
  ['threw_account'] = '你丢弃了~g~$%s~s~~b~%s~s~',
  ['threw_weapon'] = '你丢弃了~b~%s~s~',
  ['threw_weapon_ammo'] = '你丢弃了~b~%s~s~和~o~%sx%s~s~',
  ['threw_weapon_already'] = '你已经有同样的武器了',
  ['threw_cannot_pickup'] = '你不能再拿起那个了，因为你的库存已经满了',
  ['threw_pickup_prompt'] = '按 ~y~E~s~ 拿起',

  -- Key mapping
  ['keymap_showinventory'] = '显示库存',

  -- Salary related
  ['received_salary'] = '你收到了你的工资: ~g~$%s~s~',
  ['received_help'] = '你领取到了你的失业救济金: ~g~$%s~s~',
  ['company_nomoney'] = '你受雇的公司太穷了，无法支付你的工资。',
  ['received_paycheck'] = '收到转账',
  ['bank'] = '花园银行',
  ['account_bank'] = '银行',
  ['account_black_money'] = '黑钱',
  ['account_money'] = '现金',

  ['act_imp'] = '操作失败',
  ['in_vehicle'] = '请离开载具',

  -- Commands
  ['command_car'] = '生成载具',
  ['command_car_car'] = '生成载具的模型名称或哈希值',
  ['command_cardel'] = '删除附近的载具',
  ['command_cardel_radius'] = '可选，删除指定半径内的所有车辆',
  ['command_clear'] = '清除聊天记录',
  ['command_clearall'] = '清除所有市民的聊天记录',
  ['command_clearinventory'] = '清除市民库存',
  ['command_clearloadout'] = '清除市民皮肤',
  ['command_giveaccountmoney'] = '给帐户钱',
  ['command_giveaccountmoney_account'] = '有效的帐户名',
  ['command_giveaccountmoney_amount'] = '添加的数量',
  ['command_giveaccountmoney_invalid'] = '无效的帐户名',
  ['command_giveitem'] = '给市民一件物品',
  ['command_giveitem_item'] = '物品名称',
  ['command_giveitem_count'] = '物品数目',
  ['command_giveweapon'] = '给市民一件武器',
  ['command_giveweapon_weapon'] = '武器名称',
  ['command_giveweapon_ammo'] = '弹药数目',
  ['command_giveweapon_hasalready'] = '该市民已经拥有该武器',
  ['command_giveweaponcomponent'] = '给武器配件',
  ['command_giveweaponcomponent_component'] = '配件名称',
  ['command_giveweaponcomponent_invalid'] = '无效的武器配件',
  ['command_giveweaponcomponent_hasalready'] = '市民已经拥有该武器配件',
  ['command_giveweaponcomponent_missingweapon'] = '该市民没有那个武器',
  ['command_save'] = '保存市民数据至数据库',
  ['command_saveall'] = '保存所有市民数据至数据库',
  ['command_setaccountmoney'] = '为市民设置帐户资金',
  ['command_setaccountmoney_amount'] = '要设定的金额',
  ['command_setcoords'] = '传送到坐标',
  ['command_setcoords_x'] = 'x 轴',
  ['command_setcoords_y'] = 'y 轴',
  ['command_setcoords_z'] = 'z 轴',
  ['command_setjob'] = '为市民设定工作',
  ['command_setjob_job'] = '工作名称',
  ['command_setjob_grade'] = '工作等级',
  ['command_setjob_invalid'] = '工作、等级或两者都无效',
  ['command_setgroup'] = '设置市民用户组',
  ['command_setgroup_group'] = '用户组名称',
  ['commanderror_argumentmismatch'] = '参数计数不匹配（该类型为%s, 需要传递 %s）',
  ['commanderror_argumentmismatch_number'] = '参数 #%s 类型不匹配（该类型为字符串，需要传递数字类型）',
  ['commanderror_invaliditem'] = '无效的物品名称',
  ['commanderror_invalidweapon'] = '无效武器',
  ['commanderror_console'] = '该命令不能从控制台运行',
  ['commanderror_invalidcommand'] = '^3%s^0 不是有效的命令！',
  ['commanderror_invalidplayerid'] = '没有在线市民匹配到该服务id',
  ['commandgeneric_playerid'] = '市民id',

  -- Locale settings
  ['locale_digit_grouping_symbol'] = ',',
  ['locale_currency'] = '$%s',

  -- Weapons
  ['weapon_knife'] = '小刀',
  ['weapon_nightstick'] = '警棍',
  ['weapon_hammer'] = '铁锤',
  ['weapon_bat'] = '棒球棍',
  ['weapon_golfclub'] = '高尔夫球杆',
  ['weapon_crowbar'] = '撬棍',
  ['weapon_pistol'] = '手枪',
  ['weapon_combatpistol'] = '战斗手枪',
  ['weapon_appistol'] = '穿甲手枪',
  ['weapon_pistol50'] = '0.5 口径手枪',
  ['weapon_microsmg'] = '微型冲锋枪',
  ['weapon_smg'] = '冲锋枪',
  ['weapon_assaultsmg'] = '突击冲锋枪',
  ['weapon_assaultrifle'] = '突击步枪',
  ['weapon_carbinerifle'] = '卡宾步枪',
  ['weapon_advancedrifle'] = '高级步枪',
  ['weapon_mg'] = '机枪',
  ['weapon_combatmg'] = '战斗机枪',
  ['weapon_pumpshotgun'] = '泵动式霰弹枪',
  ['weapon_sawnoffshotgun'] = '短管霰弹枪',
  ['weapon_assaultshotgun'] = '突击霰弹枪',
  ['weapon_bullpupshotgun'] = '无托式霰弹枪',
  ['weapon_stungun'] = '电击枪',
  ['weapon_sniperrifle'] = '狙击步枪',
  ['weapon_heavysniper'] = '重型狙击步枪',
  ['weapon_grenadelauncher'] = '榴弹发射器',
  ['weapon_rpg'] = '火箭炮',
  ['weapon_minigun'] = '火神机枪',
  ['weapon_grenade'] = '手榴弹',
  ['weapon_stickybomb'] = '黏弹',
  ['weapon_smokegrenade'] = '烟雾弹',
  ['weapon_bzgas'] = '催泪瓦斯',
  ['weapon_molotov'] = '汽油弹',
  ['weapon_fireextinguisher'] = '灭火器',
  ['weapon_petrolcan'] = '汽油桶',
  ['weapon_ball'] = '棒球',
  ['weapon_snspistol'] = '劣质手枪',
  ['weapon_bottle'] = '酒瓶',
  ['weapon_gusenberg'] = '古森柏冲锋枪',
  ['weapon_specialcarbine'] = '特制卡宾枪',
  ['weapon_heavypistol'] = '重型手枪',
  ['weapon_bullpuprifle'] = '无托式步枪',
  ['weapon_dagger'] = '匕首',
  ['weapon_vintagepistol'] = '老式手枪',
  ['weapon_firework'] = '烟花发射器',
  ['weapon_musket'] = '老式火枪',
  ['weapon_heavyshotgun'] = '重型霰弹枪',
  ['weapon_marksmanrifle'] = '射手步枪',
  ['weapon_hominglauncher'] = '制导火箭发射器',
  ['weapon_proxmine'] = '感应地雷',
  ['weapon_snowball'] = '雪球',
  ['weapon_flaregun'] = '信号枪',
  ['weapon_combatpdw'] = '作战自卫冲锋枪',
  ['weapon_marksmanpistol'] = '射手手枪',
  ['weapon_knuckle'] = '手指虎',
  ['weapon_hatchet'] = '手斧',
  ['weapon_railgun'] = '电磁轨道炮',
  ['weapon_machete'] = '开山刀',
  ['weapon_machinepistol'] = '冲锋手枪',
  ['weapon_switchblade'] = '弹簧刀',
  ['weapon_revolver'] = '重型左轮手枪',
  ['weapon_dbshotgun'] = '双管霰弹枪',
  ['weapon_compactrifle'] = '紧凑型步枪',
  ['weapon_autoshotgun'] = '半自动霰弹枪',
  ['weapon_battleaxe'] = '战斧',
  ['weapon_compactlauncher'] = '紧凑型榴弹发射器',
  ['weapon_minismg'] = '迷你冲锋枪',
  ['weapon_pipebomb'] = '土制炸弹',
  ['weapon_poolcue'] = '台球杆',
  ['weapon_wrench'] = '管钳扳手',
  ['weapon_flashlight'] = '手电筒',
  ['gadget_parachute'] = '降落伞',
  ['weapon_flare'] = '信号棒',
  ['weapon_doubleaction'] = '双动式左轮手枪',

  -- Weapon Components
  ['component_clip_default'] = '默认弹夹',
  ['component_clip_extended'] = '扩容弹夹',
  ['component_clip_drum'] = '鼓式弹夹',
  ['component_clip_box'] = '盒型弹匣',
  ['component_flashlight'] = '手电筒',
  ['component_scope'] = '瞄准镜',
  ['component_scope_advanced'] = '高级瞄准镜',
  ['component_suppressor'] = '消音器',
  ['component_grip'] = '握把',
  ['component_luxary_finish'] = '奢华涂饰',

  -- Weapon Ammo
  ['ammo_rounds'] = '发(子弹)',
  ['ammo_shells'] = '发(子弹)',
  ['ammo_charge'] = '喷',
  ['ammo_petrol'] = '加仑(燃料)',
  ['ammo_firework'] = '发(烟花弹)',
  ['ammo_rockets'] = '枚(火箭弹)',
  ['ammo_grenadelauncher'] = '发(榴弹)',
  ['ammo_grenade'] = '枚(手榴弹)',
  ['ammo_stickybomb'] = '枚(炸弹)',
  ['ammo_pipebomb'] = '枚(炸弹)',
  ['ammo_smokebomb'] = '枚(炸弹)',
  ['ammo_molotov'] = '瓶(汽油瓶)',
  ['ammo_proxmine'] = '个(地雷)',
  ['ammo_bzgas'] = '罐',
  ['ammo_ball'] = '个(球)',
  ['ammo_snowball'] = '个(雪球)',
  ['ammo_flare'] = '根(信号棒)',
  ['ammo_flaregun'] = '发(信号弹)',

  -- Weapon Tints
  ['tint_default'] = '默认色调',
  ['tint_green'] = '绿色调',
  ['tint_gold'] = '金色调',
  ['tint_pink'] = '粉色调',
  ['tint_army'] = '军用色调',
  ['tint_lspd'] = '洛圣都警局色调',
  ['tint_orange'] = '橙色调',
  ['tint_platinum'] = '铂金色调',
}
