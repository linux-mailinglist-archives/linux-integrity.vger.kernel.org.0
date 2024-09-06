Return-Path: <linux-integrity+bounces-3475-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20C96E9C2
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 08:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B82A828623F
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 06:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383DD13D248;
	Fri,  6 Sep 2024 06:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="a8SGIg/M"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B33EA9A;
	Fri,  6 Sep 2024 06:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725603008; cv=none; b=snwWJ+6aLvEI8O44XAdWYAm01JtVjQ7CdGRrs2cTqRjhRn89MasqDo5p3KlmFnhMmA168JKRhhl3FKsDKraEGlPi6md29/f4TQOPOuEUQ6K8NCTK5kPB1qwDv/VUvMDWn2qfzfAFTb8g9LU18lKsAMCoPZjN4MkRvfuGbhBhXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725603008; c=relaxed/simple;
	bh=LW1q6aztzLd5QlIqHcH6+HCigqhHDYKggL8lh/h41DA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jza8ZCIG41UrtofjzZMi0257URJjrWIYNseeL3WdaVxx9ivt6C4NNxDevqRRadpjPmN9mj2j8e/eswbra6nHQme5MHQNTqjH2UvNytWiEaOpvbxqWOQA/bNfB0E2Ao3IjM0eOF4gx+CZsDV0I4RWN0keNUtXmFFQ6FMdDq9SxBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=a8SGIg/M; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1725602995; x=1726207795; i=wahrenst@gmx.net;
	bh=GFynZwnGItqiUxjzRL3VjbpLygPDp+WsXQoSoaZObzg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a8SGIg/Mfqb+dppCfVRfsxTHQ3Va3y/AFqG7bD0LyZ6AdhMyc5Z9czmTNHwXloIv
	 PzPxTVSgeQgoUQoinGHXU7dknc7Em/WvsU9HVBli6U1H0UFHKMG1Io+SIf3/2FxDf
	 Gq8im5JRR7iZNs5G0VlrYMZ8zLlcDRLbbViEVgz23RkF14QHfi7MrAalTrOW3tCE+
	 W03SYF4hxYdYvPsQRjykmPTfSEcfPrsq30AxZCD44t8IljaVk5TXZ2SeMMHJt6KJG
	 uv/t6XfpfaYKsXSRRNzuUL8snUSq+J4YHd9pPj0eH63ti+DGt5u47c5TRKh8a0E1j
	 24x77vIqqV3Ji7xF8w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDysg-1swNmh1wY8-006hf0; Fri, 06
 Sep 2024 08:09:55 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH RFC 1/2] tpm: tpm_tis_spi: Ensure SPI mode 0
Date: Fri,  6 Sep 2024 08:09:46 +0200
Message-Id: <20240906060947.4844-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240906060947.4844-1-wahrenst@gmx.net>
References: <20240906060947.4844-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B+VD7YechaNMepFpx+ENxUUhgduMKcb1tdJahQZ6AkzmwOwgxKF
 Lo8ayRgdvP5IdZTQstakbLUS5Z2KVzVceaZ9ZOV0bbqQwplYQRnCqG3CTF25nJ7GD9QQeDB
 TOugPJvdng3giJSDzu/rcT1Adz4XSvI3YgsdDeKIOy6rgxPoGavMWjQiD4bMUuqvsK6bd3l
 sdnzbpbLvpKK8zEXixwmw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZNAxaMGPNcs=;a5YIVMnt5RcBz5w/imkuaKB/LLm
 pEvHNM4DwboJDReyIsiTf7s2ifA85hIYA57uMKStY3q+ZOW9LX3rgRxfD7dkxbj/2qqYmDgLy
 2JI9fy6rQ9W54E8WCMK4+ifxy3XptJK24iSWyYrpucQMWMotXYNHjqO4kmIVGwzsSW32pQORX
 8EkwqPQl80Lbcg5RlmPYHCc71GmUQz4oj/HnPQr+Qc0epSvjbYwA8zuaXD6bxj2Yae1awfc9u
 ulAYZSKuNL+JWXU0gVv+Q6VdLlNPKwqXIJCeXEEk4DC8VHgbhNkeIG2MQWoJrzm54VY1R6cZL
 56+ANXZ6FGNmKIlYifKK76tlOvmITVHj+Zh4iiwh327+TgBqM9rnyMVtZyeLQEZgBHK0C7a1f
 cGzL0u7feC9Jd/F7N8/vy6bXb0sHYyvOMOmmPkZSGNNY0xzNVoXKOSVL745mOcSTqtGgFrr99
 RnTMCtKkpDUMawDASLYUudC05KBEvO6bzj+Z1+yorbIPSwlVYdNqevhQqcqkWNu2NzB/ZX1kD
 aaHXqoFds9wxLWy4pDO5hjwUUWn+x1+zPJ3bA0RuDe3iCCKtb65cb/d945oFtA6z8EO8EgJbv
 cIpYGxbzGXtUmZwqxcMSoCeBEvH64e03ATCNl4z8qg2Qf++OXdBs4y+txrt5mwbB45bXl4JW6
 fv55fs/huat7e+yFdcwGAB2BlvuHf6fy0oYjbatg0xwa6bSt1n1Z4qL4TIg0Jx0EZtvwrFKEA
 COW0iGhnHRz1DjzABPHpTKqOe+JgTY0BI4RuM2OFstPQBmzwgolQOkhgJJY+5aaymb1bQQa3n
 v8hyEUdpH+6yWY4OqkfKtXRA==

According to TCG PC Client Platform TPM Profile (PTP) Specification
only SPI mode 0 is supported. In order to ensure the SPI controller
supports the necessary settings, call spi_setup() and bail out
as soon as possible in error case.

This change should affect all supported TPM SPI devices, because
tpm_tis_spi_probe is either called direct or indirectly.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/char/tpm/tpm_tis_spi_main.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_ti=
s_spi_main.c
index 61b42c83ced8..e62d297b040e 100644
=2D-- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -248,6 +248,17 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_dat=
a *data, u32 addr,
 int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 		     int irq, const struct tpm_tis_phy_ops *phy_ops)
 {
+	int ret;
+
+	spi->mode &=3D ~SPI_MODE_X_MASK;
+	spi->mode |=3D SPI_MODE_0;
+
+	ret =3D spi_setup(spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "SPI setup failed: %d\n", ret);
+		return ret;
+	}
+
 	phy->iobuf =3D devm_kmalloc(&spi->dev, SPI_HDRSIZE + MAX_SPI_FRAMESIZE, =
GFP_KERNEL);
 	if (!phy->iobuf)
 		return -ENOMEM;
=2D-
2.34.1


