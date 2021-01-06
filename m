Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB642EBCAA
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Jan 2021 11:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbhAFKsH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Jan 2021 05:48:07 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:53596 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725788AbhAFKsG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Jan 2021 05:48:06 -0500
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 106AhVau032206
        for <linux-integrity@vger.kernel.org>; Wed, 6 Jan 2021 10:47:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=pps0720; bh=q184SXQt0DSXBU8Gby+7QCE1pkIQNnJy4sAst+H2rx8=;
 b=iIDg3MlDrz98Uq2zyDXgB2T78jWANW+ymJ/Ru9bRCenSsYBlBJ74Eo/ySNkFOHlWbHTY
 8YsjlWHyWy3pkaYN79ft8PGc8QnMTFZ9oOII9BbRTBePijPMCQ6gQbYBBgDgLiAmTe07
 7ZDK4hYakr9SHLFYjYblLG3kVHeIX0u5WWsAAOlp5hXopiPvzrrwcLF4WiPeXr81KJui
 wbJnzpeaIUxHpB3WCeIW4OQdkjl9fDDmZMITyjAkiydLoI4xm88IWE1Jd5bPkDi8Bw6r
 O5t9m18/AI97mrlLwSrJlSXnJBCJhbUtV1aBM3Jj4q5BSr84ZHuHS83bf+IVPKWmbVPj hg== 
Received: from g2t2354.austin.hpe.com (g2t2354.austin.hpe.com [15.233.44.27])
        by mx0a-002e3701.pphosted.com with ESMTP id 35w93612tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 06 Jan 2021 10:47:25 +0000
Received: from G1W8106.americas.hpqcorp.net (g1w8106.austin.hp.com [16.193.72.61])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2354.austin.hpe.com (Postfix) with ESMTPS id 12225B5
        for <linux-integrity@vger.kernel.org>; Wed,  6 Jan 2021 10:47:25 +0000 (UTC)
Received: from G4W9330.americas.hpqcorp.net (16.208.32.116) by
 G1W8106.americas.hpqcorp.net (16.193.72.61) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 6 Jan 2021 10:47:25 +0000
Received: from G2W6311.americas.hpqcorp.net (16.197.64.53) by
 G4W9330.americas.hpqcorp.net (16.208.32.116) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 6 Jan 2021 10:47:24 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.241.52.10) by
 G2W6311.americas.hpqcorp.net (16.197.64.53) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2 via Frontend Transport; Wed, 6 Jan 2021 10:47:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9h0jui5SSnE02zB6ZhKlIziEWP4f1zgFWq0tQVgsUrDXQJT7oyxzwZDa9E6C1NkLsQpFxLKwRkHLEQTLcWQtEu+krsyQj407OceDLLmxegr31cUA61I9/HRTYTKZ2OqtU0vYj85yNSClJInutV5fhYjAqrm6iAU5yMhQcfSXUhRass8Tf3u1N9CcEpz+5ktL4CJ+ovMqMiYe3QGZsOqhfOLhVOcYUtCAVtO6wGRdQUSVUKfNtGbeqswhDdhES0T+T3TuWlfC2ydHd7bXHwjYjtKmF/XZUzER/t/J0KXpB/cVU8cz9fGDvxk0tduS6lFN7sMlQaVzzMv2Wdx3+fhVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q184SXQt0DSXBU8Gby+7QCE1pkIQNnJy4sAst+H2rx8=;
 b=d8R36W8HA3TozhLmLForKTdCRSPB3H1YqismN7zxMoNlHS192AiavdULoSRZcIHLC4Op5NbpnIvXF5zCAdx2SMWQ1mIa4/jeeVJDSxVjLR6MGlczNPScI5iSltfyqxKRoHrNfvrp/bOTwXnsKZjdHsSi9ItTvmtrRnldMCSi1cbriecQaZH9OvXEvWyR/5oBaJ4P0do2WyWijH4nVofCF8dVzUB5DtaUbovDtP46ewgCf8Rs5wyC/Q1PaD5lJcVQCmPROEIrmVt7ELJkbQ7NTB0lq7msIwgrVvw5BWGygRoKZDLMygDjqwaN6x3fsaWyofRQRu8Lal17TjkHInk2sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7515::20) by CS1PR8401MB0533.NAMPRD84.PROD.OUTLOOK.COM
 (2a01:111:e400:7515::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Wed, 6 Jan
 2021 10:47:23 +0000
Received: from CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5c4:596c:2965:3fa]) by CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e5c4:596c:2965:3fa%11]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 10:47:23 +0000
From:   "Chang, Clay (HPS OE-Linux TDC)" <clayc@hpe.com>
To:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: IMA appraisal with TPMv2?
Thread-Topic: IMA appraisal with TPMv2?
Thread-Index: AQHW5BkgR8eleHg4XE+Nmh6vH0Ewog==
Date:   Wed, 6 Jan 2021 10:47:22 +0000
Message-ID: <CS1PR8401MB036099EF243892F90D07D56CBCD00@CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=hpe.com;
x-originating-ip: [2001:b011:30e0:1c2b:e975:6d3a:67bb:8369]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55ddaf3a-f2f0-4987-c02f-08d8b2307330
x-ms-traffictypediagnostic: CS1PR8401MB0533:
x-microsoft-antispam-prvs: <CS1PR8401MB05333970E7E93BFE9CC3C889BCD00@CS1PR8401MB0533.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XDd6Nq+KJhmJiC1k44fve2rqa7EDo0+GXfIlyofHvcWwGHpGnBS3klYOFFOKlQDGH4LbHdkDl0lwZ2Ah2QLvI2rfBi83GI4WLqNasRWisdiB6LdWTP6cbIJWJUz/0x6ptIA9oRxbgvTYYPXL/8jUKnNnHhBK8NBdHKiKjzzFr7S/OLF6w1crpu00ajHVv3Yuz9e27zR7cN39fS/KnqFsbFzmnO8e/cPYVGjfQs84g21gqR2LK775+54UYSOcqJ4KsEpzXbVNKztjw2SDlEFhKwdGnvc0sVLub2/3+YkDsQjrn8Q3KtJKHe6IcOBKHZQkoh2EaEHDE3W2daftYC9MMuoj1lA1eMbKTHk9ZZAdNSIHPErUJujahGPVE6YVPRFaf0KcwMJ/mbkLJMYNCQ+AKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(346002)(39860400002)(136003)(396003)(376002)(366004)(71200400001)(316002)(8936002)(55016002)(33656002)(9686003)(2906002)(5660300002)(8676002)(66556008)(66446008)(4744005)(186003)(478600001)(6916009)(76116006)(91956017)(83380400001)(86362001)(52536014)(6506007)(7696005)(66476007)(66946007)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eCT+iloEAeAkj0a3pzYueZb3/f9ak4RUlGmH8O9JCH/hviEsCSFRb4VE5TcZ?=
 =?us-ascii?Q?HZy8oXGDvYWPo8kYKET9IjIp63jK7391az5kMDRbNMPoh5XJV7iP8cID+jdm?=
 =?us-ascii?Q?fnIVZPB6SxYBpDLM46jQadRK9a7rGZ1noAAYWd4e6riJUGGQBRAxa9t+c7/K?=
 =?us-ascii?Q?mdIWO937wRC/DwoQjy4EFUri9bKsN86lTHSzh8RBM9dpn0+LIFYn+QVwXPQ1?=
 =?us-ascii?Q?ANTTq5WgHDsMM22BpGZE8fSTgtV/S5XcabyxndKGI2HwZ8uxt8iX2+TawV0c?=
 =?us-ascii?Q?LHeZaSPyVUoIRt1UxqNMtULx3ZuzY+GwxNq/UstO/0XZrwTJPYWepG2v6nsm?=
 =?us-ascii?Q?MXLfC1Td9gvusovNAJ07fAyO/BeGvCyUe1EBVxh3CdQ0UbYy7+OmRwuY5Oi9?=
 =?us-ascii?Q?mnDfeinXpFxPVAy/aXKJGhOc4925QLgRbHko+j17PGCL7XQyjT5F6Ozy+kv8?=
 =?us-ascii?Q?IkMDrhJW1JYvpaB8cvbgXl1skz0TH9Uw2Ll84Io/8TGpVZzty6VSO0oz5Ioq?=
 =?us-ascii?Q?+hmSsN8KxrpSfgScm6H9C4PAe6fphjm3I48QUvQ2dvPgmFJ2OOR6VqUQJKlZ?=
 =?us-ascii?Q?BaHkTghau2wXzn9JD4cWZAUn5vaL46Ohvh0KTMv0HvoWe1eMqGjEVnTI9qVI?=
 =?us-ascii?Q?k6JQFAjgR+22AfRKlNQAd/VHGKI1psLRxRajUFD0oRa3oZpHXbG+zQNlKO76?=
 =?us-ascii?Q?7Ng+7KrSrLiP4dx1tql6dxYPNubYlcXyf8Q8ZyBU/xzO1Ja1h+3X3AyyRRQZ?=
 =?us-ascii?Q?UpSL3JfuEklSU/ThoFNcLzO+ZdK5+OjnopyU3iDw18ZUkhXwQz9BRRhrgEpe?=
 =?us-ascii?Q?k6YWhqp9ctTYNZvZ5At92CggV6wUEPenxpSFF2TCv4+tcUnaVSurL8cyByva?=
 =?us-ascii?Q?K+yluZgIC1uYqrFwfvU0dBmplzmYmx7cMAnvLze27d7+4XdTZZT7xOWeZ5kU?=
 =?us-ascii?Q?OqZUcBqMTmW59g5OTsRcv5FJQIZaZRJJ1Oaz0nGbepsYy8J8qWa6m5QJHBV7?=
 =?us-ascii?Q?s0cmZQ2UFnTVQ9JGFeudaPi4n1h0RrS1pokL6gKe+Vfh/R+JghFkkNZqH47p?=
 =?us-ascii?Q?Ce1p1tdPHF4lzYrIoDTuUfNP8auNUA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CS1PR8401MB0360.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ddaf3a-f2f0-4987-c02f-08d8b2307330
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 10:47:22.9466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IjN67zYBX2fQvoV0TPZAu8eQ17NLzQgdvhWo2KcC8o0oK5UNpTKVulg/GeQQCFlZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CS1PR8401MB0533
X-OriginatorOrg: hpe.com
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-06_05:2021-01-06,2021-01-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 spamscore=0 mlxlogscore=643 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101060065
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

As I know, IMA appraisal with digital signature uses the public key on the =
.ima=20
keyring for verification, and the public key needs to be signed by a certif=
icate=20
embedded into the kernel (CONFIG_SYSTEM_EXTRA_CERTIFICATE). While this appr=
oach=20
looks fine, it requires kernel re-gen and re-sign in the context of secure =
boot.

My question is that for IMA appraisal, is it possible to verify the signatu=
re=20
with the TPMv2? My intention is leverage the TPMv2 device and to avoid the=
=20
kernel re-gen/re-sign.

For signing, I know I need a tool that uses TPMv2 to sign the executable an=
d=20
write the signature to the xattr of the file.

Thanks,
Clay
