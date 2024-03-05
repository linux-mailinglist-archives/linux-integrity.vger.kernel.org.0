Return-Path: <linux-integrity+bounces-1585-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99EEF872A38
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Mar 2024 23:31:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08651C25C08
	for <lists+linux-integrity@lfdr.de>; Tue,  5 Mar 2024 22:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD213FEE;
	Tue,  5 Mar 2024 22:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b="Mda0qMRZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7D218E20
	for <linux-integrity@vger.kernel.org>; Tue,  5 Mar 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677906; cv=none; b=Wrva/C3P3ysMpUoupQAmmSr+vKZwsLsXXZDv8lod70C+0t7FjEaQtPWJwAW0sQ7dhAHhSl2KfL7x5x+79it8td3QyL90mdNHS2QRUjKnYFbu8kIHZtv+v2EpJpiVIj4++IB1zLYm+HBf21zalhQg9l4AaXc9jqv3mHpPJTPa7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677906; c=relaxed/simple;
	bh=9imm9unr4A7Gh9kN8TST/hJD1F0YqHpGnOV3Z0giK9E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EdP7M7AUxcnTVlwbzt5+lF37iCL9NrtS+mpZH+CyetJIOHz9YXGPcGO+R6uhniqZSiaX9OM6u8vtBj+byWHs/g7H8T1cdTRERuEdAXopf97AFgo6874zSGUmZtt58amKzoBP4Up2O48jlyP50UJNyiWy5SCHC/RWA/4U7gtTNBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks-com.20230601.gappssmtp.com header.i=@gateworks-com.20230601.gappssmtp.com header.b=Mda0qMRZ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d2ab9c5e83so63659221fa.2
        for <linux-integrity@vger.kernel.org>; Tue, 05 Mar 2024 14:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20230601.gappssmtp.com; s=20230601; t=1709677903; x=1710282703; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9imm9unr4A7Gh9kN8TST/hJD1F0YqHpGnOV3Z0giK9E=;
        b=Mda0qMRZnldxsUwkID2O75+QDzRE3exfrjZlFKhoQ6LKsZxl06omxOfN1oy/GMiAsY
         IU8MOBrkyDP22aYQ6eqMG9zWU1FG4T/msIlEuNCauc6Xme6tNXa7MpSCMzT2x6fLEhmp
         jw2LbzLSsFi7H+PFFCzKgG28gWmoHrbIei2d4rwqTQs3m06E5gGLSqjb33XPtV6yLA8u
         rmE8FCTBfAprSfodLMWJuR072Fdce6VUpoxwqY+CDvSnl3aPgB5xiJzpNWt01rp/QgnE
         t1KM0QBurxXaUecu1SYTAwvOH5iB9uKMAwGYXtCl1pMUXvIEBUagvYYoYOTSVZT5QVdc
         iINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709677903; x=1710282703;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9imm9unr4A7Gh9kN8TST/hJD1F0YqHpGnOV3Z0giK9E=;
        b=TEzPZfny2LXgjLc8vvGYxDWt9j9LV+Qxy5vYuK/tfAzdVyW5D2zaTYxYXJFwA3SyxQ
         aXIIlkG6DEj3HKjVbhyYKdW+Ngpa1VRlUvf+ZP50AGMJ64YkebDcNEONQFwF1x8wLVnb
         5/mynGfVLbtXkTJMX7tM9i1+Fh7Dwy0T+nVDvZvOMHzysxUmub1UcEBtDt5LpxjJSx7c
         KCSQyFUVdC6V9YpT3qI9b532IuiJ1GtbnBJLnIn+wx30F8CKJp9ljrYy0th/APmUC9uD
         jIGuSKErdKhsLoeqnYtFei0koQEbmklDN0QFlGCyvBfdNTcCi2Y8JguE+aKJVr32EZj2
         aEGQ==
X-Gm-Message-State: AOJu0Yy8ur8IVj6uTonQhox/Mlc2jTiL98xSPoME/5GeG5OGPqNizHKD
	1HGmY7c1zP3sy+Lf5HbiXxGVAIQObTYAsSTKNrgyZhuH7kuc+kKG2LdBJRLn3qg+DsoTmFPtQbW
	gvMI/f+zThUzoaMH245NtFqEUIu357X4SK7xjrg==
X-Google-Smtp-Source: AGHT+IE7dkSwE2Vh+/g49LC10ib5XWl4nQqOfF2TDcp34N3YcTiD6mYwBwI85AH4kkFCW6ClBnlkjSmrkEGfx9s7y20=
X-Received: by 2002:a05:6512:14f:b0:513:19cb:be72 with SMTP id
 m15-20020a056512014f00b0051319cbbe72mr2238728lfo.64.1709677903091; Tue, 05
 Mar 2024 14:31:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Samuel Lee <slee@gateworks.com>
Date: Tue, 5 Mar 2024 14:31:32 -0800
Message-ID: <CAGL1gLNsEPXG6dXXJLk2Ucd_UAjMoa3_OS=uca5G4FvPjAMPNg@mail.gmail.com>
Subject: Issue with TPM2 Encrypt/Decrypt Functionality and TSS API Integration
To: tpm2@lists.linux.dev
Cc: linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear TPM 2.0 Mailing List Community,

I am currently facing an issue while attempting to utilize the TPM2
Encrypt/Decrypt functionality in conjunction with the TSS API
integration.

I have followed the steps outlined in the TPM2 Encrypt/Decrypt man
page (https://tpm2-tools.readthedocs.io/en/latest/man/tpm2_encryptdecrypt.1/)
to create primary and key contexts successfully. However, when I
attempt to use the encrypt/decrypt functionality, I encounter the
following errors:

# tpm2_encryptdecrypt -c key.ctx -o secret.enc secret.dat
WARN: Using a weak IV, try specifying an IV
WARNING:esys:src/tss2-esys/api/Esys_EncryptDecrypt2.c:322:Esys_EncryptDecrypt2_Finish()
Received TPM Error
ERROR:esys:src/tss2-esys/api/Esys_EncryptDecrypt2.c:107:Esys_EncryptDecrypt2()
Esys Finish ErrorCode (0x000b0143)
WARNING:esys:src/tss2-esys/api/Esys_EncryptDecrypt.c:328:Esys_EncryptDecrypt_Finish()
Received TPM Error
ERROR:esys:src/tss2-esys/api/Esys_EncryptDecrypt.c:110:Esys_EncryptDecrypt()
Esys Finish ErrorCode (0x000002c9)
ERROR: Esys_EncryptDecrypt(0x2C9) - tpm:parameter(2):mode of operation
not supported
ERROR: Unable to run tpm2_encryptdecrypt

Further investigation led me to the discovery that the TPM I am using
does not support the TPM2_CC_Encryptdecrypt2 command, as confirmed by
the output of

# tpm2_getcap commands | grep -i Encryptdecrypt
TPM2_CC_EncryptDecrypt:

In an attempt to resolve this issue, I decided to explore utilizing
the TSS API instead. However, I encountered a new error when
attempting to create a primary context using the tsscreateprimary
command:

# tsscreateprimary -hi p -st -opu primary.pub
TSS_Socket_Open: Error on connect to localhost:2321
TSS_Socket_Open: client connect: error 111 Connection refused
createprimary: failed, rc 000b0008
TSS_RC_NO_CONNECTION - Failure connecting to lower layer

For additional context, my system configuration is as follows:

Kernel version: 6.6.8-g19a0c7318c79
Installed packages: tpm2-tools, tpm2-abrmd, tss2
Discrete TPM in use: ATTPM20P by Microchip

I would greatly appreciate any insights, suggestions, or guidance on
how to address this issue. Additionally, if there are alternative
approaches or best practices for achieving the desired TPM
functionality in my environment, I would be eager to learn about them.

Thank you in advance for your time and assistance.

Samuel Lee

