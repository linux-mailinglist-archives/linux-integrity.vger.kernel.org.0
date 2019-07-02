Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BEA5D686
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Jul 2019 21:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfGBTBB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Jul 2019 15:01:01 -0400
Received: from mout.web.de ([217.72.192.78]:50995 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727087AbfGBTAz (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Jul 2019 15:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1562094040;
        bh=E3pGj2dkiDZ6+glyTl7AWQYkPf1IakfUILl61N8Rv88=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=bWg8MEFHsbla8weMkXk51pxmcmvarfsO4dImH4kFFAkETXoyAM3DhcFOoXQNaKCOt
         5DjtaLcYzmLTNg8RNUnzFM2kNs/m6HPCazFZJgHAoWY1nqgYzypVoeTY/cb0G3KjDB
         /HIdm6I1PEq3zcvNL0EwNDOzjSE+C9/0m4pHSsNs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.11.114]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lo0V2-1iAr4a1uiO-00g4Sh; Tue, 02
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
Message-ID: <6b3e3f9e-926e-e010-de27-58d75360ff6c@web.de>
Date:   Tue, 2 Jul 2019 21:00:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:t4C5SWgNpyGMSpO5wujwsihAs4WnKfYEQJLHmMb9b2dxPmAGdpK
 dSVwDhS9kjYuYWZmN/atywIQ9/2tEyGSVuyPohNuZWFoVlutEdr7B5LhIROrqizdmtMTx1l
 fPbpWrKMFDZP0ZC9Wst0vSYEmjlM7oJviwvMzwGy+nWzl/qArw35l5hmEj2EHTesGJop2KB
 SH+ZhU8OhrnNwF83cwTog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/ATCcu5ryUU=:D3Vbk0etYlPIBPH95YUk9g
 XiCH8zI8mceBua08eD6fwvGS1NCc9/tmkI6c1kT3iq1cM1XcRt7oJDPNIyYzf+vCHlq1Dyfnp
 66hZEEC/TQPFNnjCcly79KIgTMQh47CbVQ7vsFf/R6Wps8QnyNLo54b82f4f54jNd13CKaysW
 zEOweUA2F7ZWbiLvYWsvQ0pSRDtZqQ8B5C9UKQMR767Mnp/dfVVE6YP48bOMT89F/sGvjKXMl
 9VBDRFC+m/zsIeCtAB3qE592CFotlJ0ALQWIIWo4n5p7ZYnLjx70+CvAQ3U4OxZVXwo59Rf4P
 /5F+k7/kpEsJvwxKiGPDmEJZzSEfEP9ZyPW3PVeSjW+T6Bc26ywSxPEVkVUjNXsKTd8fdgwrl
 YVvYkSCqgOKeCkSj+TDQ+ImgV8AHrqawgaHwPwHlZ6XtCmYBotxDc6rbVg4EIanwWhoTqmD+1
 gv9G8AMRSD99CAtOec9UK7PtsWoqAnzGtv1ZXXjcPnoeBShD9J0sPLCwQ8usg3SCJ9E490uAj
 BNQF+9IByea6W53I7oxjo2N+NJGrKsY9dSRJw90xSNL0doEXZtmd63h12wMDf8gkwdEsCTEso
 4YXDMaSv4tSP5tPY2xOv52EyBh/c3BtbWle4krT1OixWhx6Jywyetvq88PWHiQVCMwQ4Pk9p8
 7O4fGtK6qNLpuB+U/7r83P5h2upffLpU9IwynGYTy3UmakDaZwdGAkJUX/r031KTKQ+jcn0Y0
 nrg3dxiq0NvrweVEXcWaDBl2N4O1nc5Sx0w0mwa0C8MF+Id8Cy4eIkoDnRW27vpAl1LUz4eBp
 kIFq32pPmjScjd7c42Rt9NvGfLpLidIEZhdof3GDReDjyznBrDU0oL1bm0terb5qlveIfov4L
 2Hih0pnjGWIw/SeuDbDu/pBJTXoCZ+TOcifOunKXm1a9xk3djtlU4Pn77CWL0iuj9ZeU5kMv7
 Fy1Fw4B/RvTV11KoeNxqQQTyLeI6KdbPcMrWAF56Z094xqE+gB4CIU0BjAEx1lyhiJEC/WK8X
 U4fqUG0PzdVw+7aY2qQpNMERfHMGOn7gydkbcGvKJ0itjsQ8w1pznRrjwHLJ/TtpdG6XQP2om
 xMSWu1GBeLR9jqeCMGI4iqgy3frhKjcqkHS
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

