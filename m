Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C13995D67C
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2019 21:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfGBTAy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Jul 2019 15:00:54 -0400
Received: from mout.web.de ([217.72.192.78]:44445 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbfGBTAx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jul 2019 15:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562094041;
        bh=E3pGj2dkiDZ6+glyTl7AWQYkPf1IakfUILl61N8Rv88=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=C601VR8Hi8PIlCpfgrtCjCTRKfGyRxJdzErAoDbrwZ0oFqTOxcKmJdP9P6N/Of9Y+
         BrNi9GpaET/ilru8EB+Lz9f69rbJeNxCCNSrLv7i2PmZZHooGD4jAgaHzlCkGBd2qO
         +HkL1lQ0VqQwiL4eHik14pyUXJo7I6ncYai4+RrM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M2uWg-1iZfaw2bLi-00se0K; Tue, 02
 Jul 2019 21:00:40 +0200
To:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] ima: Replace two seq_printf() calls by seq_puts() in
 ima_show_template_data_ascii()
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7f60a9e1-3002-3186-2a30-50b69abd0cc7@web.de>
Date:   Tue, 2 Jul 2019 21:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KFkYLIY1npATDLLhuwbMwksEqkmtX6kkYsSV0Vd5j+uT98uc8s8
 ytf9I4RR3CVXfh3qQeqLpbbgSnArsFUa22Eibg6d2NbdtixPr58KR217by6cPmPAkd2m6Un
 0IL5gpxmme3Da5VSz36bKQBAm+NLF2goyoCt0lmFSLmhSgWTtUmcr6H1C1WFdmePPVwD3KP
 AoPd7IZXFUBD0v+0upWTw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:jFmE59tYiBk=:SASPnTibklJREuEIBB+wz0
 Cb5YsV+cMMgSV1tbU/NOvhu49pP8/MgZ7GVVfrvN5sAsmCCiQExF/fx7B1AqRl0UKeQvyQnuL
 jdHaBbTXDJUD0gACWD+hBi0afqeuT1d1r8jJkvXZ1yH9CArZQm8RDuBWFJamIaSCrc2dj/UZV
 OnjHYEZtVqBN89OgYztx5p3QVppBiwzEfvl3Ngx2xEj/MctQad9hdQMgFx2V1fjUppcmX7fAc
 8PSBHdz7V6eBcFbT6sNmPXCr5ubmGWi03zmwxMen0ceK126uTKPs0sX2TJguLLupoY6kIrGqz
 bmVBwoMBI12McDOUCEotOETdzznsCzxSFK/opGpdQdqCpVjQNKKOAkQLSFRi6oGB4botoFy8i
 nMkS+BDlxZi9y7prnS7VNBoF3FmOca0LVfq28C1l12DjiSROx2UZfmmFM7jtdc4YX4faDDeV2
 UirDaHtgzWWNWWvnXTjGt9KQTpK8jubnDAbznM8XOoRv3Iel6lI+TnrVcILvm0Vga4pXfs9Ma
 kgYnwS9C2EIzm3jlB5aXjI8XpZouNBN21HDGenU06l5IU5g+Nplx1Z0vrnc/qki6Pg5HB0mx5
 IwD3eLjT0agbzihELRnLSx0cH5JNv1qFGQANqCHuELNe8HSAHR3jvA2fJ5TObftCQ7JQxHvgT
 j+4yWzWmiZ+NTsBgr+LKbhHkenn2r6pHFH6cmPZm2NL0jBI+T+6/FeJcArrbV3J61yaVjxqBR
 LWNT1TUpX9Q5ZY/zsYXt/wIHtDTfy+YfjsKL9bvI1Z2d32PZhnZEStiV137dCtg6PoZbbPsM2
 CNz4adpenZLSm8uGSa9jNeOzO86RHDV3ARDRgGh0oZ5JvxGUW90XxrSMio28hBl0bPiCJiSoR
 F1gTlXTM/0cL72w/NFBeeRy7wqAqfgQNvO/skrMj2cEQgcHCq7RvNlB9256/t2539C4NJTD15
 V4rIEI4NnOnYN7AWBJwf+XlkAq1ds1nqxImeoTAzokTvi8ae9hGP1eKr5kMULLbn0+aLxA2EG
 2TrN6F3QPkENadNqGHz9GLYzZ2syEZLAe+YLtEgM0YiMNhbmbWQk9bdFg1uocMxOPpi/qwQ4y
 M0MMNQcKIxD1Gr7ZR5++nAU6ti4rLY3OqO8
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 2 Jul 2019 20:52:21 +0200

Two strings which did not contain a data format specification should be pu=
t
into a sequence. Thus use the corresponding function =E2=80=9Cseq_puts=E2=
=80=9D.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 security/integrity/ima/ima_template_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrit=
y/ima/ima_template_lib.c
index 9fe0ef7f91e2..05636e9b19b1 100644
=2D-- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -74,7 +74,7 @@ static void ima_show_template_data_ascii(struct seq_file=
 *m,
 	case DATA_FMT_DIGEST_WITH_ALGO:
 		buf_ptr =3D strnchr(field_data->data, buflen, ':');
 		if (buf_ptr !=3D field_data->data)
-			seq_printf(m, "%s", field_data->data);
+			seq_puts(m, field_data->data);

 		/* skip ':' and '\0' */
 		buf_ptr +=3D 2;
@@ -87,7 +87,7 @@ static void ima_show_template_data_ascii(struct seq_file=
 *m,
 		ima_print_digest(m, buf_ptr, buflen);
 		break;
 	case DATA_FMT_STRING:
-		seq_printf(m, "%s", buf_ptr);
+		seq_puts(m, buf_ptr);
 		break;
 	default:
 		break;
=2D-
2.22.0

