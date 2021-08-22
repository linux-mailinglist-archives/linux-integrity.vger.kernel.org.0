Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FF13F3EC0
	for <lists+linux-integrity@lfdr.de>; Sun, 22 Aug 2021 10:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhHVI4M (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 22 Aug 2021 04:56:12 -0400
Received: from mail-eopbgr60137.outbound.protection.outlook.com ([40.107.6.137]:52929
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231147AbhHVI4M (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 22 Aug 2021 04:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNmMih+KOk2QljwIFjUTPvLMNp664pYyKqSCmT7WboXJC0lHfeNKe80Jhlp0W7hLVlRhNCs5I/K0OnKFazmVfquPs90kxsAa6ceOdoaMo1conmsUD4wQXM6PchOIOl7giyi2f59zAW0t/FZVKLlZpc4hpfAfAnerm6IzbuUBFk1QlvkR92Zgld58YLDdxt/A421y5LdnQWQXVFhMpGU5y+G6loFTa7aWMNoYCMfJ1eGjHr3SP9gK3E+62T+8cFiGWDi/t0CvOg+enzIN8F1C29e/+7IIEX8MJzHreCwJKNay9ms+/jwUHI41Oi+IChdDyV/QqFTxjmA5VjMCpPQBjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXyx6bC4VNsiuVXpHas2qZ2VKkd+CLbPLjByi5Ivghc=;
 b=kg0e+ZuUX86QK9K4RSnqGRLu1dc09ZFUD9MyQMEuCZ7s0E7ofwXeR9UxtSoAG/bb17OcdiNZbxfwuX7OlBIhK8HisRy8fhsCi7mVF6UraA9/PEK7ip8ONrNe3841QIjuFhCc9Uz9o7f6KPg/HyxISQPq5FngW7mn18cPyDxHRv1vMuwP/1woRDxfm1u9aLndNlx88s7Ht16hQR6lpc9Z7fGPr5FYB5IuHUb9dG4yi1pKDgOrfDk0DBfUs7Ju6wwwWAEojug2zdJY54XgeUrrLYTn/QacQh0boEqhs5+ROBhBruWGkHBe2lYVeyl0926d3KSBTQJvcWkLso+w9QsOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=viveris.fr; dmarc=pass action=none header.from=viveris.fr;
 dkim=pass header.d=viveris.fr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=viverislicensing.onmicrosoft.com;
 s=selector2-viverislicensing-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXyx6bC4VNsiuVXpHas2qZ2VKkd+CLbPLjByi5Ivghc=;
 b=x1159Bi3PdbDOeb6p2kkI90I/0PKrsF0Sr1eh2+gI9F9qMxqfitMUrTUwxEmAe+37mjF91/bdQ/Pa4HjYr5QCtpp2Sb3EMJglZ6pQkee2zqdUfvnALmS5K0LGRt8v7pSCfcmC/gbHsL+dkxr+4qtXOfEdnvc9zbWsd6oSyAJ7sk=
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com (10.171.86.149) by
 AM0PR09MB4260.eurprd09.prod.outlook.com (10.186.189.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.22; Sun, 22 Aug 2021 08:55:27 +0000
Received: from AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432]) by AM4PR0902MB1748.eurprd09.prod.outlook.com
 ([fe80::84a0:780d:1c5c:4432%9]) with mapi id 15.20.4436.023; Sun, 22 Aug 2021
 08:55:27 +0000
From:   THOBY Simon <Simon.THOBY@viveris.fr>
To:     "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
        "dmitry.kasatkin@gmail.com" <dmitry.kasatkin@gmail.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
CC:     THOBY Simon <Simon.THOBY@viveris.fr>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com" 
        <syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com>
Subject: [PATCH] IMA: reject unknown hash algorithms in ima_get_hash_algo
Thread-Topic: [PATCH] IMA: reject unknown hash algorithms in ima_get_hash_algo
Thread-Index: AQHXlzNzlHGs/yvMiUCFw3wJEmV8JA==
Date:   Sun, 22 Aug 2021 08:55:26 +0000
Message-ID: <20210822085522.3416-1-Simon.THOBY@viveris.fr>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=viveris.fr;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84c0924c-12a0-4685-6b1c-08d9654a962a
x-ms-traffictypediagnostic: AM0PR09MB4260:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR09MB426076596E0C95239306098994C39@AM0PR09MB4260.eurprd09.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: otbcYgxYhK1d1o9VrlGp/N8Coi9Z8YVexNLBOOnyBe8nQYNTg7qQhkUDI3jyXsrY4ROD4yj4T6RzxrMuP0BdmIDxO5i+8uNhakJ7i+9f4yp1+RInTzkemoPQ2PBZtlqJ8eEg7PbdFbxGHWZKXhcOgHq10TSrX1ADn9KZduiHjbrX/+bRgrskOMvCyXlthKT0vhugMHp8wCRxSfwmzICqMBxn9JP0ITlRU6Niw5zBaxhDQUnO63KViD+yNtL76kBxm98vPWS3bOr07PZ4R6RPazhW47p6z2b40H+7U33CUuhCIyITLekJdvE1Xx+2TsZAzlR0rXJyE7wLxPL/UY9UeN5xiAhEQeFv8+IeBr7aoBHmINYSonI9wgn1N5Yth63TvRaZ9fIe6d0FPtkfYeYwgMrQeq/w3tuD12RvZKFz2fEqdX1WyEDcyEctmiwTcYZ0w9zRohe41OZosGPd6SrCj5hPtvNWIqhEtHBJpi/+Y4b6WM7nd5pZOFyPbSbRpSrXxa7Wknsaof4a2DygShHLQSKJg9IJCPSz3ZlWrHp5gk68DdccrRwBJ+glZsx3QlhnVXegha7ZDBj3iPC8EmLWcCB2YfLujIR45dZwx+tiZT3P/gjG4qRXc1PR8OsjFWf8giYuMHjGo7JBBx+KA7sKuBCVrlAUoIkaDMptn/frjv8X8nPHOxpMdbHwASyeCgunmQntyb1cYmBQPJP1d9EBpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0902MB1748.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(39830400003)(366004)(376002)(36756003)(478600001)(64756008)(66446008)(66556008)(66476007)(316002)(8936002)(6506007)(2906002)(86362001)(38100700002)(38070700005)(1076003)(83380400001)(122000001)(71200400001)(26005)(186003)(66946007)(110136005)(76116006)(6512007)(8676002)(91956017)(54906003)(2616005)(4326008)(5660300002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?np6dU+kFg1DLsn76sKNFwgfKFgRFLVB9rQJdV+iuuins35mbDbi8HBTRkX?=
 =?iso-8859-1?Q?2WY/nt9b1OQMhM7ePCKXTv56JAZEHwtWqlw/JYMdASRVrzqFqyjJDzUAbV?=
 =?iso-8859-1?Q?BjaKUjIOYRoMyEZrRg1oS0Y2TfuAx40MNF8yFNFuuOxmEzZUxEiHkqgRLQ?=
 =?iso-8859-1?Q?O74+sfRUH1E1BBRojNi/cWSr2ekt9kIqpO53BPL0Tb52nI6KsK5IPUD7me?=
 =?iso-8859-1?Q?E1U/QIDZn8c7ViQSXX+a5NCBIJgo90/H1RevqWLp7BJ69KU+J7b5V7T6Yk?=
 =?iso-8859-1?Q?9JriGv2/KDCZCW2mJZgtrc6QVkKLIa7MCuKhy8Fd6bhU0OjfUWO7NB38MT?=
 =?iso-8859-1?Q?u1v6K3JelicFnildL2h15X5GLPPitidDFLmfH6HOshpU3VSDdWPU9rN42n?=
 =?iso-8859-1?Q?peZ/QGqBLVIdC9bUrdGJi9eecnnspVpf/kacabUCrLKl6rk7pYispkjyMO?=
 =?iso-8859-1?Q?YQES33HEmeD+3DWF0epcRW+5/xeegCJbWcinvHVo8zUhv6aasjB7UgGdYl?=
 =?iso-8859-1?Q?qehp/cxpdXCzQr0l7GUJ/Q/Vk8ft4S4L5y5lCj0yeRRl7Vunu0vfonRg/8?=
 =?iso-8859-1?Q?TA5+ajs6u06X7wkc+pBtV+b6dyaDpvCcaJuA8+RCwGe2LpPTAZF5P4MgYi?=
 =?iso-8859-1?Q?DkBGU41rjqrXUqta5MtFEqn3je8Si6bKskekRGqtRAvFV7jL95PQw4h1gf?=
 =?iso-8859-1?Q?DRE8GshVUOTLMnQY2glTfO/j2rS1LoBCGCLJHgfJbG3tI4o2I8LyeGNYTO?=
 =?iso-8859-1?Q?Q8+IrdPn748+1f3VpgNvwEGMQ2agC7LM7fBBbhmjY2c6EqnV+0xUQg8pjJ?=
 =?iso-8859-1?Q?4KjFiGSYtrlhi8EE3eLFNaBnbCp8iMHKm629xOtKjFOPL9ayYx3fMaBul0?=
 =?iso-8859-1?Q?adnbB4HK7mItpYSK3W2SoYuw+0u/bDUMkiSkge5gYGS8KPPghbE7qoODVV?=
 =?iso-8859-1?Q?Hu8+somlQvyqATufmhMPcWLyKYTWA3LcILFOvUD1lZe+UYcYq9UxJAoT9E?=
 =?iso-8859-1?Q?6HQfOufI/eoE8wmHFqrlVQmXn1R+BR5nCL5nJBhHW4s+e0ix7CfR4Yi/Ni?=
 =?iso-8859-1?Q?RKISAi53RuVVEKkSUqPj9lVjPLkrD/JZOtCouPqnZtNL6Vut0PQz8PSGbP?=
 =?iso-8859-1?Q?Lfkeo5VsTOtVMyxSDmrjjQ3KtPB7Xq1KGcLq7Wweh667rSSUb9Hy9pLJmu?=
 =?iso-8859-1?Q?Vy2E4173RLEyT/sUdr0I6gQhDvat/MP3CozX7X9690yGBJRMO1v3wEwl7i?=
 =?iso-8859-1?Q?/3Y87ovDlwG32u+YIvSAzihhjCNObSkGxZMFGcp3b1vsdGCfefoPwNgIIU?=
 =?iso-8859-1?Q?nFg4X2T0/vi8UchStXKmKe2ZRrN/ivgv/1sw/GYrepST4tz8GKX83k2Yve?=
 =?iso-8859-1?Q?fKPN/bvYfX?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: viveris.fr
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0902MB1748.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c0924c-12a0-4685-6b1c-08d9654a962a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2021 08:55:26.8624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 34bab81c-945c-43f1-ad13-592b97e11b40
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FWxg/8lxZuyLcywid4kBiBHSNWjIFxb6fZRV3yr3r/NS6EaQhTKXnZI6gM2S/vm5mQf2bOXB/CjmGRCKgkKLpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4260
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The new function validate_hash_algo() assumed that ima_get_hash_algo()
always return a valid 'enum hash_algo', but it returned the
user-supplied value present in the digital signature without
any bounds checks.

Update ima_get_hash_algo() to always return a valid hash algorithm,
defaulting on 'ima_hash_algo' when the user-supplied value inside
the xattr is invalid.

Signed-off-by: THOBY Simon <Simon.THOBY@viveris.fr>
Reported-by: syzbot+e8bafe7b82c739eaf153@syzkaller.appspotmail.com
Fixes: 50f742dd9147 ("IMA: block writes of the security.ima xattr with
unsupported algorithms")
Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_appraise.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima=
/ima_appraise.c
index 8f1eb7ef041e..dbba51583e7c 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -185,7 +185,8 @@ enum hash_algo ima_get_hash_algo(const struct evm_ima_x=
attr_data *xattr_value,
 	switch (xattr_value->type) {
 	case EVM_IMA_XATTR_DIGSIG:
 		sig =3D (typeof(sig))xattr_value;
-		if (sig->version !=3D 2 || xattr_len <=3D sizeof(*sig))
+		if (sig->version !=3D 2 || xattr_len <=3D sizeof(*sig)
+		    || sig->hash_algo >=3D HASH_ALGO__LAST)
 			return ima_hash_algo;
 		return sig->hash_algo;
 		break;
--=20
2.31.1
