Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2192C8D98
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Nov 2020 20:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgK3TBi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Nov 2020 14:01:38 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:61062 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728893AbgK3TBh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Nov 2020 14:01:37 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AUIwKWc011917;
        Mon, 30 Nov 2020 19:00:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ecbwHD7lADCyROxAbu8X8uXItdsOrOqVJOR5Xb9uzpU=;
 b=Ts9bnl/W/9biy78zeuqDRyL0MavZyaEKQXxlJ8T00hl4dSHFJdd59LnPE2DpqZjObhN7
 WVAY3FUktqQecOidDQa2jLzb13d1FxqeIZvNXHnCuV4r+xLMxp0RAowL0QkMVPd14/2h
 YVtqtnbM1RPJ3d7WViBY9y3BKKyAAu4y/3yRtINFzi/iCyDcYFBRZsbuM0UcgXMIpfY6
 MwpAYsc/XmWbtYJGDmhvdCKwYO/EdQ23zfdDnEZiEhQ/O2pc7A3EteOWeVUwPj4KGEdO
 7/0knN5zU5p1e+1QNb9saC/IWW/NS0rcp3MKdL0f/GSkO2xhFvO43ObLvk+tSlMyoIbe 9g== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 353f73gqp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Nov 2020 19:00:48 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 6FA407E;
        Mon, 30 Nov 2020 19:00:47 +0000 (UTC)
Received: from G9W8676.americas.hpqcorp.net (16.220.49.23) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Mon, 30 Nov 2020 19:00:26 +0000
Received: from G9W9210.americas.hpqcorp.net (2002:10dc:429b::10dc:429b) by
 G9W8676.americas.hpqcorp.net (2002:10dc:3117::10dc:3117) with Microsoft SMTP
 Server (TLS) id 15.0.1497.2; Mon, 30 Nov 2020 19:00:25 +0000
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (15.241.52.13) by
 G9W9210.americas.hpqcorp.net (16.220.66.155) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Mon, 30 Nov 2020 19:00:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRglIN5lI9xDUSkNT5ExBUeXLjxte/6kWQEU4inNUkVNe2ooV7J7YYkWgNIrVHquMuYtLRHuIARbsd+768JT1LxLKkfq7GIZVN80CP85lKKumYG9vF5PaUwpL+0gX7mBejqHoJvYiXZwzo4JDvx5GSN/pGRwGhb61CP6xRJ7lMlKwv/AARJsRH9o4B0pMgrpPok+0JqpjOxouig+3BHXu7vZEnIG1bUbLxPQfIqymcSz2sGrxltRGc2F9rmihAsWDL+zy0tMOc5XK/AxLjIgxp5LtzmnPE+Rhb/mg1jlrOuFKbUOd3LEUqpn+XInOS3T2vmkuliJthUoZ5LkNs29UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ecbwHD7lADCyROxAbu8X8uXItdsOrOqVJOR5Xb9uzpU=;
 b=ABFhmE9mjLDPJ3JbU/VB2GxCanak48zMYCumXYSdQ2oVRikWN9ZBx4jQA76bgbQ3IMlgro3X16HBREZWmCDJJJIL6zL+AtEctHSgKxbjZwh3OaagXDPgEThJf4n3PUaczKu49vixwS8VAjg5bQn9hsbYthFUHL6exApVQlTsu8EFxKULF0R+EB27Y1o1R6GyoR53+idXAxmOl/SLwn6gv0GVdgo36IbSDZNewuFWpR4HmMHSUKz0ubIKinz6UDUowd9wYKh0ipmztJwMTVW0U3pSxaLCdwyEVENwR2zYkZ5ox3Gg8F+c/grmsXHwye7s3axA48OgLGDGd6bnU3ErIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::15) by TU4PR8401MB0989.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7712::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Mon, 30 Nov
 2020 19:00:24 +0000
Received: from TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::19ba:3192:911e:431f]) by TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::19ba:3192:911e:431f%12]) with mapi id 15.20.3611.031; Mon, 30 Nov
 2020 19:00:24 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: RE: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of PCR
 registers
Thread-Topic: [PATCH RESEND v4 1/1] tpm: add sysfs exports for all banks of
 PCR registers
Thread-Index: AQHWxp+HLLKJZ3u700mE70YfYEXLaKng/H3A
Date:   Mon, 30 Nov 2020 19:00:24 +0000
Message-ID: <TU4PR8401MB105585A7FD1E1EB317FD13F7ABF50@TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM>
References: <20201129223022.5153-1-James.Bottomley@HansenPartnership.com>
 <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20201129223022.5153-2-James.Bottomley@HansenPartnership.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: HansenPartnership.com; dkim=none (message not signed)
 header.d=none;HansenPartnership.com; dmarc=none action=none
 header.from=hpe.com;
x-originating-ip: [2601:2c3:877f:3f20:656a:e649:499f:e4d0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6c7c35cc-99b0-4a67-ff92-08d895623164
x-ms-traffictypediagnostic: TU4PR8401MB0989:
x-microsoft-antispam-prvs: <TU4PR8401MB0989D5409A371179A74D3AA1ABF50@TU4PR8401MB0989.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zfZdXwY/mxKKyCMRJXO0bA6wFV4oqqRXxK6Lya5l1nwhGXVFDg/Eyjwy8TLifcTrq2paggrJUn0tdkwZ385preWgnlzg/ade974YhxpWC5VZr680IkR3jiH120+XJDprJ5yPdgZhkOp/MbM91n0SYlS+XDO1SklNIE+/cOFGTeN+lx/VAFFUJzTXhcqwh5CldNvRfP8prclwlHdPM8ukSz8gZGpWAzOqOUihZTTo9Mt4pLDds6RAL3U8xu+r9un8c//ofS292zdoJGlqmbNhP7DxW7gLBMA7UxgGF2CwyyXGJdd26I9aj/HLcyfakmpaB85K21PDhLoHQ0sukJjJzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(8676002)(6506007)(110136005)(54906003)(316002)(7696005)(2906002)(8936002)(15650500001)(33656002)(9686003)(4326008)(186003)(55016002)(66946007)(86362001)(5660300002)(64756008)(478600001)(52536014)(76116006)(71200400001)(66556008)(83380400001)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JskLfMT87u8RjPhxlfiVoApXkpXOtJtEW6RiyUkuTTqLXCcAln5OTnUAPtce?=
 =?us-ascii?Q?3yW4vMBakYtw9rWPdHTBBm8VKOyZFnSjxlGCOhQr2OG93sMBf4uFiH6hUQnZ?=
 =?us-ascii?Q?HVhVAr4YJKs4QGMru5/yyvglH8QVYYQ7mTRgSKwQ45gJE35Fru0IKl+7bgVQ?=
 =?us-ascii?Q?VaGNt6YjPwBD2QdB2+2VmB8sDjxOj8bzLRmnXwTUSuBEZyu2Iuo37gZzhI/p?=
 =?us-ascii?Q?VU2JLH8ri+b8TEzW8hDLc2GnFkGTxnzfjGfBfGtekJd8e3LkP4AKxfCe9eYw?=
 =?us-ascii?Q?Ly82Dba1BWqX0RA6oSt0EAnM6XXephU3LN9pFSN+mzWOgrIXBDN+4iuPBjXq?=
 =?us-ascii?Q?4pqav4HBvlws9hJTdP4qe30I2eXEd55OXjjcadudCRqGScILhfcRfSLbzio/?=
 =?us-ascii?Q?KtF52VD550p1tnitqDJhhmGRWrI0QPCQ1kbqoukP6ENoTMBRt0Dk+VK+m7Mq?=
 =?us-ascii?Q?oPyVynK+0mEh8mbRTWkGhqgatz7Bx0bdGgxX2k9OlqIyZy1P2YMXzBP1aDqh?=
 =?us-ascii?Q?mvsIuohS8X+jwlm3q8ay6TTXDlP0p6H4gwdVPuRUgLkRah7VHfWhgICaT97f?=
 =?us-ascii?Q?Oqh7ppa8Rc09j1gvcqcaaeaTlLgRzj9JdZMxoki4dv19x4EEB+CNJ3MnUjjO?=
 =?us-ascii?Q?kxo+6bEU+7U/lPuc9LZ1pVoO9B3Vcq/aPDROe33jSWww3UQ6b3o0SdbLCDD8?=
 =?us-ascii?Q?TN987zIO7pRCjWFX63NJvmn6PkjynVIM1earFKkB/NpDA6wEZLhzRbdMru+w?=
 =?us-ascii?Q?nCtJGd3dSjX6BDhBjv5gzaVK7yKYzDTNzwwDVSjTGbDeh2365iXNAjhSeMrM?=
 =?us-ascii?Q?GGpeBH9NL2LJj2Td2B2CNV/y2HVocoExG8e92hCXkG45txs7K5MJGyBB8Bqe?=
 =?us-ascii?Q?ee/6pGYW4SfZN7Slbmgvh0F+2OhEpcA3Fx3WwI/vBu93I5/bm4Z3SsV2KluH?=
 =?us-ascii?Q?YWElb6Exg7+bvBC2ov2nn4K0XK1WkkJpnCZ5jUpwZ5evZ/BhuMGrsYcnYP9i?=
 =?us-ascii?Q?5QvSa9Gou/G4CEPFWDrjAEMLMLx1vBbpoZZVh5/DN+9FRXE=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TU4PR8401MB1055.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7c35cc-99b0-4a67-ff92-08d895623164
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 19:00:24.0291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEN0HUD4MoJzDjHn7j2B4nXyXfCj8c6jhPzxH31yPEUbMb5Wgzz/9KWM0+24dFQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TU4PR8401MB0989
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_08:2020-11-30,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011300122
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

...
> + * The first argument is the TPM algorithm id and the second is the
> + * hash used as both the suffix and the group name.  Note: the group
> + * name is a directory in the top level tpm class with the name
> + * pcr-<hash>, so it must not clash with any other names already
> + * in the sysfs directory.
> + */
> +PCR_ATTR_BUILD(TPM_ALG_SHA1, sha1);
> +PCR_ATTR_BUILD(TPM_ALG_SHA256, sha256);
> +PCR_ATTR_BUILD(TPM_ALG_SHA384, sha384);
> +PCR_ATTR_BUILD(TPM_ALG_SHA512, sha512);
> +PCR_ATTR_BUILD(TPM_ALG_SM3_256, sm3);

The latest PC Client Platform TPM Profile and TPM 2.0 Part 2 Structures
specs also define codes for three SHA-3 hash algorithms:
  TPM_ALG_SHA3_256
  TPM_ALG_SHA3_384
  TPM_ALG_SHA3_512

...
> +
> +	/* add one group for each bank hash */
> +	for (i =3D 0; i < chip->nr_allocated_banks; i++) {
> +		switch (chip->allocated_banks[i].alg_id) {
> +		case TPM_ALG_SHA1:
> +			chip->groups[chip->groups_cnt++] =3D &pcr_group_sha1;
> +			break;
> +		case TPM_ALG_SHA256:
> +			chip->groups[chip->groups_cnt++] =3D &pcr_group_sha256;
> +			break;
> +		case TPM_ALG_SHA384:
> +			chip->groups[chip->groups_cnt++] =3D &pcr_group_sha384;
> +			break;
> +		case TPM_ALG_SHA512:
> +			chip->groups[chip->groups_cnt++] =3D &pcr_group_sha512;
> +			break;
> +		case TPM_ALG_SM3_256:
> +			chip->groups[chip->groups_cnt++] =3D &pcr_group_sm3;
> +			break;
> +		default:
> +			/*
> +			 * If this warning triggers, send a patch to
> +			 * add both a PCR_ATTR_BUILD() macro above for
> +			 * the missing algorithm as well as an
> +			 * additional case in this switch statement.
> +			 */
> +			WARN(1, "TPM with unsupported bank algorthm
> 0x%04x",
> +			     chip->allocated_banks[i].alg_id);

algorithm is missing the letter i.

It might help to print the bank id (variable i) as well.

