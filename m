Return-Path: <linux-integrity+bounces-5197-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4ACA584A5
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Mar 2025 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFB4188E0B7
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Mar 2025 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90651D7E41;
	Sun,  9 Mar 2025 13:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="W5zHiu9Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068A91C549F;
	Sun,  9 Mar 2025 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741528230; cv=none; b=Wuwrhyk5t18FhFXz6CIi5T2jRfXadhgBfia9XEx5qQb4B/9TD4gXaH1Vf4wd5Gxm6TR+2bBaMDeiiu7LSSVy5IBdJFWARDpmBZwBKt+khOypz9AY2Pv1yTkXOSDG2r0ZX/7WZSiEutfcaeZaxlr21z51SmLE6+Vz4k9FVoWCnBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741528230; c=relaxed/simple;
	bh=wU+5CEn5FrkXdwKXM76N7KyIAXlU/EDsxmpPBGRXI10=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=edflseEWb3VXEQxpWHzb4iUg5SvKbRKaMYWYiX3Sosv2v7lWUfriJCt4w01y+ilnckkUwUS1OERiPIOTlMbj0MawELazAk3+Yv6pPKTpv/2ew/absURciPHqepQwnTnui0sUVa2jFE0M68IsTc2JqW4rEyQH4j7WOvW6KyptX2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=W5zHiu9Y; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741528225; x=1742133025; i=markus.elfring@web.de;
	bh=Ti2Of4sCs6CYg2FBatUAg3ntENBfhycGeOXXT5c8zX0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W5zHiu9YtQQvwrtpylKpw3d7r38YTW6fQ4Mo54KCLPrNXX0DShIghE4mtBC44g8C
	 wcVNBp+GJYOmsnGB1PVuGkcbnjbOj4/tKbiZPasqsLMIygtfwUKruPDgJJb4v1gks
	 uFq6AJzS0PQkrjGDxUqPOWMqIUilatW0V8b7h/otF6hfWPfNeneXCKJNXp47Q2ziR
	 Qnbn8G7z2KNbU+YhUqmN1LWdokHIyk5YTXYroVW3zDyrxsdTecPeKdaUDM9jE2IAa
	 WgyG68PSfGHnAzLVqUTHR7O/V2KxbkF7XviGHyO7NxW4VBXIWyWGtyyEdq1C6LxlA
	 VaPR10a9fV0+oY4zlw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.26]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MAtwr-1txcpU1ESn-00Fyvl; Sun, 09
 Mar 2025 14:50:25 +0100
Message-ID: <76001d9d-fd98-42c3-9d93-6594e9de8e26@web.de>
Date: Sun, 9 Mar 2025 14:50:14 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-integrity@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?Q?Peter_H=C3=BCwe?=
 <peterhuewe@gmx.de>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] tpm: efi: Improve exception handling in tpm_read_log_efi()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FMW1rO1kiv+iqRU0iHBgllf/fNmE/LI/vLKrcwSOXl7k3lNTVI4
 tH9y1cWEhmoiL8imgVs2wSiMDiSeweFNBx90yjptTimG4Zo+NKsKrg61GxRhC5WC/NNqJL/
 zFgFuGDCa5JDmKPXMfLI3DIsDsuMFJdmPUkAFRGvvXVF38nfBrpiyg/Hxw7YqlAQ5xsvtBj
 trTJKHL6o5GBpiO1h2aRA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uhr9BeHjhsg=;mRFaEVIaaEM2Rbw5FvdMsgEMIk3
 EV7s+bTlZ+hPBl+D3jLG+THf0/lOTkfwSDc+b9TUo08O/Jupu7PCOmgaXTp2xJdBWoCpkTfVj
 LKCMlEO6ADrncENDCHgtXWG9QoFTp2ZgKpsKV0QnMQ9FsxpXAXBUgxnIztiEBJYsnNHZsUe5t
 Aky+unsbWoTP4MkteovYWsBRZZShw1MSS8aY5giKsKXYZ1Cz+QWuultQyMi5eQEM9YXo68lI4
 FJ3HxKIFGWtp059J90V5229ykojDcs8GS9L7Je32ktdWRt5SiWnMCv849EWE02Bnayu6BGOWw
 5PbWHhxDoMj2drSf4tuL09WnJKUmBM0YoRVANZNFcSqwAcUKrxY7iGLba+ZY8RWj+3t5+h0fr
 EWDRUrViSlOAvsCmlweocfRIHaUwQllRi7NrlI2B7eVlikLoiCZ4iPeuMxLKXQlul0hIu/PFF
 gKrElGEhZMGFHvW2e/bTnr53XKFoI/JL2YApg6drDYIKuOVcvSW0b91QQyBqy8pKKHSTZTgVT
 BSLahqs7wT4TvUiSWBcNFfn7quGgU5qf9lzoZmNvwxOyjL9hFhikMmFhvRCiPRUkj0dTFJtbt
 aFs29hCi0rCyxSQf4hLyfFWKjMYH8QiIgFziWGyOwjXOsY6rEF1qK4hRkQCbcHQtYskK2TKUQ
 5XbPgiGIxbkRXNBbpp/Qc6IA1Kchx9a+N97ASlf9NbbEzDeTXZ8MwfbI8AeBwNgusMtvZBq1N
 4jx5mahR8ssIvpBD+NOmI8UN9hEvLZhP8cTk7Qk9nmWmSe/mdJw8YxxWFD36tvTOhWtQQlkbE
 mLaD4WMD+VkLuDCXuYUsBFV0YMvA5PUZVf2Fsc3Qws2skzUK2P6z1XCrU5iXiQ403vAE0yXA3
 px3kERePCUV+neBfsx5+3AQAoDDHx0L5ohdxg1J2Coz2/gG72dBOU0+75W3kagq7bN2VCUoDx
 JyvRcPkPXtv22xpwfaVVRaCbMBjB11XPf4+xGFIB6mYuyp17cyXljNLwSdo1Ocb6J3sSR/t1C
 QKV6RAt1NNj3BNg03oo3ImkE+7odh61aGBS/h9gazpyFJ8j4nQO6VG0Fxtakz31vAuqv7o6vR
 gJ5uhxeIk1CzsGzC3GNR9Zjk/KDAzAL6Fzppo+nvcSr0joiPH0VRwLwETX4BTdBP5HZvQ03XX
 AgSDX9KG49P0VF9MrligJJuJXCO7HnOvbJAqWiHhwW0ShWM079pRfAmHuDCFhcHjAsOwf3M4E
 L2qJb5VFM4DWhWXZbawaUHynQtDF7WlZQf0M/MoXin+stbZJ8DSe3tBAzvchfPEVXAtuCy3tF
 yMG6A1gxe49qqdB0F3tPd6jYrdknrnbViMzZsUlSm2GYUZMUvF9XwpDldKpe5cUW8TQR39Paw
 GQI+4+vFS1izyrzAXUI0wFjJswb7IuVKvm+KOUX2yBICugfXyNlxyQJ6+SfPoabP/m/yce95v
 XZ2YVD7quxju38HKbKG+RXVsryZs=

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 9 Mar 2025 14:43:52 +0100

Add a label so that a bit of exception handling can be better reused
from an if branch in this function implementation.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/char/tpm/eventlog/efi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/efi.c b/drivers/char/tpm/eventlog/e=
fi.c
index 4e9d7c2bf32e..472292e9d52d 100644
=2D-- a/drivers/char/tpm/eventlog/efi.c
+++ b/drivers/char/tpm/eventlog/efi.c
@@ -77,9 +77,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 			     MEMREMAP_WB);
 	if (!final_tbl) {
 		pr_err("Could not map UEFI TPM final log\n");
-		devm_kfree(&chip->dev, log->bios_event_log);
-		ret =3D -ENOMEM;
-		goto out;
+		goto free_log;
 	}

 	/*
@@ -96,6 +94,7 @@ int tpm_read_log_efi(struct tpm_chip *chip)
 			    log_size + final_events_log_size,
 			    GFP_KERNEL);
 	if (!tmp) {
+free_log:
 		devm_kfree(&chip->dev, log->bios_event_log);
 		ret =3D -ENOMEM;
 		goto out;
=2D-
2.48.1


