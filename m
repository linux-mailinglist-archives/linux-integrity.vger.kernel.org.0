Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 072693BE601
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 11:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhGGJ5g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 05:57:36 -0400
Received: from mail-db8eur05on2120.outbound.protection.outlook.com ([40.107.20.120]:20865
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230408AbhGGJ5g (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 05:57:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhimPgzhHxN8v2z7593Cr6oB5GYIsfiUFII1D0bOIwnCyp5qy5qwVgx11vsI9Li6UsBWRkvhzkzWM4s7Fg9Jtl0el6UMllKqTK+aITNyDSRPJ9KIE70e7xll4rRivYvd39xV1HO1JklAkv38EwzjsfG3qiJUSsbqzn13Nt+01tHvWgItpcZlBg3oRkZIaefH5Qbi47ZSTVvX5FpX9yGuh2ioSM0PtfpbTME/aLVAKpEO+EhGURG0/SBOjQO6wmRtm1BN/reA/NtmbVfY9n9etMXQvE7Z33l/J6ht6JAn6JAn9u4ndJjfEXNyAxizf6us0MuZyhimu8xsD2gmc63kgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLw1HHMo7gI5HfdpOBX7yCRKNwNinUZ6LqDghqYiqPY=;
 b=ZmL0/lrQCqcp8HFfYJeGX7O3HAug7fMEfugN9gu4coxv1z2cMbVcpUaLzXYtSB3C/8kCEeynCC1HxdOBTgia56GYHKHg0KiassBND1tv5zVFNrb6mg3/8gy7pL0miH4l+wqcTJgm4fPJBZsR6rB7tFmUdK+G+nWOj4+8Xwd0Y29X3CDjukAynImzvalkYUeTOv37hgYqj1biDsbSJL36UPiF6fFp8Vyd25EJ5LrHJM2BH2xJdkz7HZHuli9bQvt5KLwZzdaEhw/wgE5DjfXlbn+lvuAl65kKXkQNPKXSJzMf+It5rkVNJ+/m1BkJ6siUMXXnMaIk9C0EJ8XA+Je6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FLw1HHMo7gI5HfdpOBX7yCRKNwNinUZ6LqDghqYiqPY=;
 b=4SxM+QXQNtTmK44pmV4SJvJzclPGLcbC75DwIXtxc241I3y+r2VD0Y91inssTWzwCX4lamwOcW6NjAIIC620ukrRAteCwk9sAXAEu3tnB3w1OdOSovITo5Q6BUTsCKRapFgmJDiI/Kcyw48qEUhDfkmslRnNmI8QuUR1lCRzmQM=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 (2603:10a6:200:96::21) by AM9PR09MB5140.eurprd09.prod.outlook.com
 (2603:10a6:20b:30e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Wed, 7 Jul
 2021 09:54:54 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::1d19:ecb0:b073:df73%12]) with mapi id 15.20.4287.033; Wed, 7 Jul 2021
 09:54:54 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Weak hash algorithms allowed with DIGEST_NG
Thread-Topic: Weak hash algorithms allowed with DIGEST_NG
Thread-Index: AQHXcwvZ3imzEUWtz06ax4bC82bErA==
Date:   Wed, 7 Jul 2021 09:54:54 +0000
Message-ID: <AM4PR0902MB1748D83387C6F3D39C98992F941A9@AM4PR0902MB1748.eurprd09.prod.outlook.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 251f8d61-11aa-4c68-3be1-08d9412d4593
x-ms-traffictypediagnostic: AM9PR09MB5140:
x-microsoft-antispam-prvs: <AM9PR09MB51401E6EA60728C9BD046E85941A9@AM9PR09MB5140.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LAtzD7DFtKPsL7PpzLl9zdLsRRal/8LV33BzFDkq6r3NCOM9bUsUcudvpCmZjaLtykaWZ/2XFvD5NZeblj9HaYGmjFFn29mTgIjetByQv0Dl37bibxgqJ9wRciRuc7ieDfyZ/E3UqN4WrTl5AM5o+/MV1uiMrKRzd01RvNegbnaEyjregBQtgtuQ5W/t7efp4610WQDhbcw6/xvXpgVq5yYXrc4nSkZbFwlBC9RDN9eD7LeIu6UQ7Mr61J569ZxPBwTlpGaXcYN4XQ8F0GML2bbHbJdoy/HhDkTqua+UoVU2CjSnvjiOvhhCPNTmWbDCw83VqtczmHJdyLGdHZvlYX1JgbA2TfHE0P3mXZgFFE7fZWjLyV6CLfPhWxc51+aF6aB+KRpKokXI19N1Umj/vrYm1slMHnJoHaOf+c8/qYmiYer1VXKYTCGVjgaS+RFGv/AHGP82iaHpZdYjbonPRGxj5i4GI55zJ5T5HKm95nXLdBv0hMD7EKAmkV/Eth/W8OhkcXmTcgIX80OyXywP8TpFv3wcmkUaDhVjlvsdU08bKzrr8M6Q6AMXZ1G8+DORsA77n+wcCvpdP/0vW5TX9RJj4yecvM3CvsHEYfjSglZsxKntWD65cBbpvdVHBdQca8AcgqCNcCIZ2REjrHl4Qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39830400003)(136003)(346002)(396003)(376002)(64756008)(9686003)(38100700002)(66476007)(55016002)(71200400001)(66446008)(6506007)(186003)(91956017)(8936002)(76116006)(66946007)(478600001)(122000001)(83380400001)(33656002)(66556008)(86362001)(5660300002)(8676002)(7696005)(316002)(2906002)(6916009)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IJetWuqztDvFnJtv/YBEjhBmJjDTrIUs4AT/xN0pYw9zl4ohA14gq5TMH2?=
 =?iso-8859-1?Q?MDz+69qCAt8VkoiAr89YOdip+RlKymFEBa6rmN/CmS8ziWNtKs6eg/bvI+?=
 =?iso-8859-1?Q?76yzfcYw70rvxwbO/ffFdPZ9zcaLGff5iJLhNNJaSHVlBUoIYZx6N/EVjD?=
 =?iso-8859-1?Q?C6OlCfL+RBgtESnzWLKCmKv95TSo1ecjPiJzJ696WXz9hwwBebXBI6keXc?=
 =?iso-8859-1?Q?JqYWp4kHMkRA1FI+lbdoPtisqBPXSNFuMbNEgNntjmrqVRfVycGMTgUBWl?=
 =?iso-8859-1?Q?yum+yipJ7lYMoL/6dQti9ZMD++GE8GzpfoIPw+JDYTpxaOrITD/Hy5AbCi?=
 =?iso-8859-1?Q?LstAm9EHudbtfd9qE4IOtronnnABYDv83YYkef0/MGmGgOSOfRwZj+T1iX?=
 =?iso-8859-1?Q?4VRM/gTc3f4JnzIntIfIq4Yh3/lCcga6cIGoSI2Arx0DqJrfTrNBh1h+cz?=
 =?iso-8859-1?Q?hU7/77QnK3Lg/8dF30AYwqIIcLj54k2946WagAZFjHJXfYobw5z9ETSUm3?=
 =?iso-8859-1?Q?dDCuUqGhDGtucidEnrGDnx50tRAKluHJrjOcit68nA5aqhmZBkTGD20nwI?=
 =?iso-8859-1?Q?Cu4n1Vslm0NLDKykqu8uwsKsR6OQEpAn7ZhckcJrEbRj1sjiDXmwBsSrFE?=
 =?iso-8859-1?Q?fQ5y7rt4tk94eDGpgsOw4svY13OISuB9tPFJgMZfka6eQz29KuB/7NTA/b?=
 =?iso-8859-1?Q?yp3dn7zsaJfhX/jE0rB3gGxibQ+CN90dyr8cPGHtm8UpsjzyNZR3kRozNJ?=
 =?iso-8859-1?Q?Mzumqkm6AXUwbs+AIWpTKvN+dgNaM772s9HQ0/ElrHL71I0y4WfnX03oFL?=
 =?iso-8859-1?Q?4ma+1P4iMxF4htPa3k8RpLdRb24xxoUpTh2iuOf8s1bR3DQQap1Y2qje4+?=
 =?iso-8859-1?Q?zaiIYwksj0X5lpO1g9a5yuU5ju0yZ00xij24yn3YyiHVvyB//gqmNC907r?=
 =?iso-8859-1?Q?IfSmGlvZGU1edw6Pq+ZmfYK3YsxxTtTB5kVLC0ufAzqQUmxl8TrWJDn9Zf?=
 =?iso-8859-1?Q?7bS7cKhjLjKTh/VFbdFCbOEp9GG2x2YlRcH9ehS4i4HL6UG4IqTai45qMl?=
 =?iso-8859-1?Q?pspPlb3paYZa/m8UBDIJKqtWpFX2Q10O6b2OWd1MJMWqIGI0NWwuqSw5hy?=
 =?iso-8859-1?Q?NfVWSFwzotMPzVbmBLKnXWYsPrq7o4kfrXX6GjtPMEOErY6KSw0/hbrnSK?=
 =?iso-8859-1?Q?d94DcJP3AGUBHaA7HW9k7NC7WQrhImShl6vnbxmB75YiCnb0j4HACDayzm?=
 =?iso-8859-1?Q?YO5aReFqLKRcbT/zAIOK2s2XiRTPp2+MOzucilcXm5/4oT3RZIit4FYnaC?=
 =?iso-8859-1?Q?5WshqhvEL1wzl2pUIHlMlj7eqqYZ8jAa817qATZWW49hsI/2yJU3lnsE5U?=
 =?iso-8859-1?Q?+xLGYd1QATQOafm5m1V6E+oNx/Su4flPcpKZPI/k70c1F4MeZeNn0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251f8d61-11aa-4c68-3be1-08d9412d4593
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2021 09:54:54.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jg3KwWsk64N1u5LgJPE/ggViLP3RPXjLVvKWgtZVDhMS0TmM1tx9ytAboZrkl97HPCMAiRjT/vtcCN2zB96fYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR09MB5140
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello,=0A=
first of all I'm sorry if this isn't the best mailing list to discuss this,=
 but the "users" mailing list on sourceforge seems dead since around 2017. =
Maybe there is some other mailing I missed ?=0A=
=0A=
When using evmctl and IMA-EVM in hash+HMAC mode (no digital signatures invo=
lved), I was suprised to see that IMA didn't complain if a file was hashed =
with an algorithm "weaker" than the one specified on the command line.=0A=
Of course I suppose EVM should stop downgrade attacks (by that I mean an of=
fline attacker changing the hash of a legitimate file from sha256 to sha1 o=
r md5). However, if files were already hashed as md5 - or more probably sha=
1 because that is still the default value for evmctl - then the attacker co=
uld potentially perform collision attacks against the weakly hashed file. T=
he user may believe himself protected against collision attacks because of =
the 'ima_hash=3Dsha256' command line parameter (with or without 'ima_templa=
te=3Dima-ng').=0A=
=0A=
Here is an example on a CentOS 8 box with a vanilla 5.13 kernel:=0A=
=0A=
[root@localhost ~]# cat /proc/cmdline=0A=
root=3DUUID=3Dxxxxxxxx ro rd.luks.uuid=3Dluks-xxxxxxxx  ima_hash=3Dsha256 i=
ma_template=3Dima-ng=0A=
[root@localhost ~]# cat /sys/kernel/security/ima/policy=0A=
dont_measure fsmagic=3D0x9fa0=0A=
[...]=0A=
dont_appraise fsmagic=3D0x6e736673=0A=
appraise func=3DBPRM_CHECK fowner=3D0=0A=
appraise func=3DBPRM_CHECK euid=3D0=0A=
appraise func=3DMMAP_CHECK mask=3DMAY_EXEC fowner=3D0=0A=
appraise func=3DMMAP_CHECK mask=3DMAY_EXEC euid=3D0=0A=
appraise func=3DMODULE_CHECK=0A=
appraise func=3DFIRMWARE_CHECK=0A=
appraise func=3DPOLICY_CHECK=0A=
[root@localhost ~]# cat > /tmp/a.c <<EOF=0A=
int main() {=0A=
printf("helo\n");=0A=
}=0A=
EOF=0A=
[root@localhost ~]# gcc /tmp/a.c -o testfile=0A=
[root@localhost ~]# evmctl ima_hash -a md5 -d testfile=0A=
hash(md5): 0108f04837b9336d40b8ec4f78df320143=0A=
[root@localhost ~]# getfattr -e hex -m . -d testfile=0A=
# file: testfile=0A=
security.evm=3D0x02a0cb5aab84522b5bc9d662998786676ad27ad142=0A=
security.ima=3D0x0108f04837b9336d40b8ec4f78df320143=0A=
security.selinux=3D0x756e636f6e66696e65645f753a6f626a6563745f723a61646d696e=
5f686f6d655f743a733000=0A=
[root@localhost ~]# ./testfile=0A=
helo=0A=
=0A=
By the size if the security.ima xattr (smaller than a sha1 hash), the value=
 of the first byte (0x1 so this is a DIGEST, not a DIGEST_NG) and the fact =
that nothing was pushed to the audit log, we can confirm that md5 is truly =
used for validation.=0A=
=0A=
In addition, I am sure that IMA is enabled and working, as can be shown in =
this example where I craft an invalid IMA xattr):=0A=
=0A=
[root@localhost ~]# cat /sys/kernel/security/evm=0A=
1[root@localhost ~]#=0A=
[root@localhost ~]# setfattr -n security.ima -v 0x01aaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaa testfile=0A=
[root@localhost ~]# getfattr -e hex -m . -d testfile=0A=
# file: testfile=0A=
security.evm=3D0x028fa94dc0950002fdfb2674ae94a7677fc5fb4ff4=0A=
security.ima=3D0x01aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=0A=
security.selinux=3D0x756e636f6e66696e65645f753a6f626a6563745f723a61646d696e=
5f686f6d655f743a733000=0A=
[root@localhost ~]# ./testfile=0A=
-bash: ./testfile: Permission denied=0A=
and I get the expected audti log message:=0A=
type=3DINTEGRITY_DATA msg=3Daudit(...): pid=3D1428 uid=3D0 auid=3D0 ses=3D1=
 subj=3Dunconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023 op=3Dappraise=
_data cause=3Dinvalid-hash comm=3D"bash" name=3D"/root/testfile" dev=3D"dm-=
0" ino=3D2224735 res=3D0 errno=3D0UID=3D"root" AUID=3D"root"=0A=
=0A=
So I took a quick glance at kernel source code and indeed, when looking at =
ima_get_hash_algo (in security/integrity/ima/ima_appraise.c), there is no v=
alidation for the algorithm used:=0A=
	case IMA_XATTR_DIGEST_NG:=0A=
		/* first byte contains algorithm id */=0A=
		ret =3D xattr_value->data[0];=0A=
		if (ret < HASH_ALGO__LAST)=0A=
			return ret;=0A=
		break;=0A=
=0A=
That hash is then used as-is in process_measurement (in security/integrity/=
ima/ima_main.c):=0A=
	hash_algo =3D ima_get_hash_algo(xattr_value, xattr_len);=0A=
=0A=
	rc =3D ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);=
=0A=
=0A=
ima_collect_measurement (defined in security/integrity/ima/ima_api.c) then =
proceeds to use the hash algorithm without further ado:=0A=
	hash.hdr.algo =3D algo;=0A=
=0A=
	/* Initialize hash digest to 0's in case of failure */=0A=
	memset(&hash.digest, 0, sizeof(hash.digest));=0A=
=0A=
	if (buf)=0A=
		result =3D ima_calc_buffer_hash(buf, size, &hash.hdr);=0A=
	else=0A=
		result =3D ima_calc_file_hash(file, &hash.hdr);=0A=
=0A=
To confirm that there was no validation, I took what appeared to be the wea=
kest hash to my non-cryptographer eyes, MD4, and I decided to hash my file =
wiht it.=0A=
It appears evmctl was not really conceived to use md4 (and it shouldn't be =
either, so all is well), and we need to apply a tiny trick here:=0A=
=0A=
[root@localhost ~]# evmctl ima_hash -a md4 -d testfile=0A=
hash(md4): 013785074a0decdf72f189fce55ff3c743=0A=
# We need to drop the 01 prefix (that indicated that the IMA type is DIGEST=
) because the DIGEST type uses the digest size to determine the algorithme,=
 and only supports SHA1 and MD5.=0A=
# To use MD4, we must use the newer digest type (digest_ng instead of diges=
t) to use the oldest algorithm. I dare say this made me smile a bit.=0A=
# We will prepend 04 (DIGEST_NG) and the index of the target hash algorithm=
 in the hash_algo_name list: 00 because HASH_ALGO_MD4 is the first in the l=
ist (see crypto/hash_info.c).=0A=
# This gives 013785074a0decdf72f189fce55ff3c743 -> 3785074a0decdf72f189fce5=
5ff3c743 -> 04003785074a0decdf72f189fce55ff3c743=0A=
[root@localhost ~]# setfattr -n security.ima -v 0x04003785074a0decdf72f189f=
ce55ff3c743 testfile=0A=
[root@localhost ~]# getfattr -e hex -m . -d testfile=0A=
# file: testfile=0A=
security.evm=3D0x02aaa230ee23a3d82169c346711eea31573c861348=0A=
security.ima=3D0x04003785074a0decdf72f189fce55ff3c743=0A=
security.selinux=3D0x756e636f6e66696e65645f753a6f626a6563745f723a61646d696e=
5f686f6d655f743a733000=0A=
[root@localhost ~]# ./testfile=0A=
helo=0A=
=0A=
Is there any way to enforce the use of the hash specified in the 'ima_hash'=
 cmdline parameter ?=0A=
I couldn't find any glancing at the code, but I didn't read all of it and I=
 understood even less, so I secretly hope to have missed a small yet critic=
al check/option.=0A=
And if there is no such way, would you be opposed to a patch adding an opti=
on (something like 'ima_enforce_hash_alg') that only allows digest hashed w=
ith the values supplied in the 'ima_hash' parameter ?=0A=
=0A=
=0A=
Thanks for your consideration,=0A=
Have a nice day,=0A=
Simon Thoby=
