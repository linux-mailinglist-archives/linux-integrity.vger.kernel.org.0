Return-Path: <linux-integrity+bounces-2434-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA38C889D
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 16:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A7B21F28966
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2024 14:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2482A73539;
	Fri, 17 May 2024 14:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gyP+hOW6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730D473165;
	Fri, 17 May 2024 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957607; cv=none; b=odq6qNtjqmacha+pRXaRUONDJtLegCLXcvH30oNmfexjIk+VtMGxeChmdnbbVazJoknq1+LOWr6aWWRFu16EtfB0uT5ToyjRY7O4d6HAbyHoRTzyScEh1ialyjs9AcCG6KKJr+2+Ci53V9Aan82HD4R4iHwHk/44ASMP5rByhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957607; c=relaxed/simple;
	bh=BiV3QU1AT/xes+kLUBL9MgFm921WrEPqSiZSWGVCR98=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=gxRfzYlWduESndvvG+z/tr+SKZy09h6lWvOU5iuFIh2v7cImGb3lm4XSg2Ga7pyZ35DSxdKcTfIGTXNwRVBPx05d+9QQYjB+MZj7is/DHxACV13gfdI+B7qt+EhhXHAyRmX6nM+6rBkvxT/4iiQruy/k6cS3q0DW0ad0DOqH5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gyP+hOW6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a5a89787ea4so457716366b.2;
        Fri, 17 May 2024 07:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715957604; x=1716562404; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KYyhvUNfZdQUyjcK8lugFY801XaI//MGY8IupV8s60k=;
        b=gyP+hOW6Q7xqKUuPdKfYLyrQPLjtj8BIcNX+Y0R8pJO4xfPg5V/B1oYfPJVPGIbBW/
         c5H7etnyQkQ2kgjEi8mBrx7F46S4DO6Bw7n2WMVxlfC+6AN8RC2exgujP0gqx1zRsxxP
         gzGJ3GaBTnMMz+VsndExJtk8cAGASDdP+tHLDpIAcJWXc5ekw3jIz4i2S/VGVD5W8Qs7
         Y3HRCNq5e0Kypt7VBGnhH5tjJcbyT0BHJsJeGM3ZkXeTmMIxWjatl+tE9D6ECpAbYcAW
         1NKTfHXPiJ03jzkrV2YJYOjQmNNSvSynT8weHHVENwuz4rCx2dAU+lx9cBliePLNC7ON
         W7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715957604; x=1716562404;
        h=mime-version:user-agent:content-transfer-encoding:date:cc:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYyhvUNfZdQUyjcK8lugFY801XaI//MGY8IupV8s60k=;
        b=vT2hYM0eRXkVr/qwkjbhN5HMGKCMqIyi7r5BZl/UoOCkh59ZE0xhxLIEjCmksMIJ7P
         Y/JmyvbKd2daM83I3/7rlT7mAQzoajtP3Vl0BF7ZJ2fWmcJr95KUSohU5HwyDLyZ1I0k
         uBqM4c4jWLDiAK39hcLzh1mOKR7vBf+VglYbkX+Y1RPJKFZYhvSWluB50nJI5xb0RGkg
         ki5m4dWhQK6LhNB5BXVvfmTITCLvsQjmkV/T4qqrjI5+iQhwn7P3Za7oKgMblEX631vV
         x/cmCJooboLeY0tStLuz89dB/4T9M2meamYUE9YBGeNYBc2sveGbIa3Rto6z1m0TVxYI
         nbuw==
X-Forwarded-Encrypted: i=1; AJvYcCU4xggE7XHzuSVv52SbNE6/QdrPJM2ZztdHh4a0TIZkb3EipZ2gS6CDuUZEkxG7ePVtscX4HtLfzX4FYquQRooFeVhco2/+J/rli6C2
X-Gm-Message-State: AOJu0YytSGmAS9IewhwoF3SKfjeDP8PyXEfSjMJKJ6CcEQQ08sP5/zc1
	dgZYDKuQm7gd+bP2ddRkWIrHznqxQElmvkL7RUJIyr1qBan002usfDE8s1I5Sr8=
X-Google-Smtp-Source: AGHT+IFZ5aqjl34jdp0iFNScBSo81K86cI1cStF9FYz9DzT6j9Ui8qw88E/R/j6+5xreDtYChmVl2A==
X-Received: by 2002:a17:906:4808:b0:a59:c31a:91be with SMTP id a640c23a62f3a-a5a2d54c571mr1427809766b.16.1715957603540;
        Fri, 17 May 2024 07:53:23 -0700 (PDT)
Received: from [192.168.10.8] (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781ce5dsm1116168766b.42.2024.05.17.07.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 07:53:23 -0700 (PDT)
Message-ID: <bf67346ef623ff3c452c4f968b7d900911e250c3.camel@gmail.com>
Subject: tpm_tis_spi takes minutes to probe
From: Vitor Soares <ivitro@gmail.com>
To: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jgg@ziepe.ca, jarkko@kernel.org, peterhuewe@gmx.de,
 vitor.soares@toradex.com
Date: Fri, 17 May 2024 15:53:22 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Greetings,

I'm using the tpm_tis_spi.ko module and it is taking several minutes to pro=
be on
kernel:
 - commit ea5f6ad9ad96 ("Merge tag 'platform-drivers-x86-v6.10-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86")

root@verdin-imx8mm-07317726:~# time modprobe tpm_tis_spi=20
[   57.534597] SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm2=
0p
[   57.560684] tpm_tis_spi spi2.1: 2.0 TPM (device-id 0x3205, rev-id 1)
[   57.584943] tpm tpm0: A TPM error (256) occurred attempting the self tes=
t
[   57.591797] tpm tpm0: starting up the TPM manually
real    8m6.438s
user    0m0.007s
sys     0m0.013s

...And after probing, sometimes the system becames unresponsive.


I did the same test with kernel:
 - commit a38297e3fb01 ("Linux 6.9")

root@verdin-imx8mm-07317726:~# time modprobe tpm_tis_spi
[   53.643744] SPI driver tpm_tis_spi has no spi_device_id for atmel,attpm2=
0p
[   53.668404] tpm_tis_spi spi2.1: 2.0 TPM (device-id 0x3205, rev-id 1)
[   53.692997] tpm tpm0: A TPM error (256) occurred attempting the self tes=
t
[   53.699879] tpm tpm0: starting up the TPM manually

real    0m2.809s
user    0m0.001s
sys     0m0.022s

I tested on kernel v6.8 and same it takes same time. Do you know anything a=
bout
this?

Best regards,
Vitor Soares

