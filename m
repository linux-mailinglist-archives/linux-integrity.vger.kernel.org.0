Return-Path: <linux-integrity+bounces-7563-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 296CBC31314
	for <lists+linux-integrity@lfdr.de>; Tue, 04 Nov 2025 14:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 00ED74F7860
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Nov 2025 13:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723A02F6178;
	Tue,  4 Nov 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlYkb6KR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC32E2F3C30
	for <linux-integrity@vger.kernel.org>; Tue,  4 Nov 2025 13:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762262021; cv=none; b=QyxqRAemkG0EnyJ7Xuhn95wf4rIOJtIMGUhxA21ap+FzBSsb9WM3lyZMWEB0lF8NkG4qGVJYAmV2ZLByGbaT3fBGbRnMG9y9taSKUdEf/iqD7t94MUrikyEZh7ObNAKS+8rsuiNrnNBNcvq74ER71tf7G7bsSZeCRS3emofPyNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762262021; c=relaxed/simple;
	bh=zReFbCpQpq9hx7S5OuXnYnE+WALGscFOwncxZWVvVD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvM9krc88xRRzudYS6H5TDcGviZC+39TKuo7TKEX0Sx6gsXJHexGyjB701frlUcB1/G8Fwx2YgTYAS8yfk7QUJVmdeHGpzuTGQRvBKucul0c6uTlQn0gb/Au3kxmNLq897x2pFyD/qQdhY7S/QJKi4QaHakXMnVLDVShBKgXU8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlYkb6KR; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29555b384acso32490325ad.1
        for <linux-integrity@vger.kernel.org>; Tue, 04 Nov 2025 05:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762262019; x=1762866819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQu9QKoK4tGUZ4g1byHHuUCj0MWqs0LgGabAs46ovQI=;
        b=dlYkb6KR/UW9LKWC9ves9afbFubRq69qhTidO/jqnz4jxTfSKfbh0c8pdOBPUMEpjd
         ANM/SV4e+opVC47L+0JgEz619QAnnyNk+HM5bQiVQ9sLTiS/2numzUPog15MGLruP08o
         NHeFyHy2B6Tg4lMzXyZThDP5S6whqybd3Y5s17GiCIRjStBA4wvvtnqxsam48EOYqiMb
         EGPDR8xGGxync7uy7MAPEjmW/iak2U6qLYlfDXWw8kbrzQx44e4y6xNSxc0jad/yGvrl
         nR3j5hFOXzVAYSoGiFVPqllo4D7khBoN1tjlcbOwxptjbBkMfWgUx59k3j1Ti3cRt45o
         wftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762262019; x=1762866819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQu9QKoK4tGUZ4g1byHHuUCj0MWqs0LgGabAs46ovQI=;
        b=N3t95saM3eke7WNVqbZh5Bk/PhXi5A4SoANoWdrxh4Aj0FncGOmt5XPkl5NoihK/3a
         zUwzpcUV4YE+L50aejh5gR9fyENEG0nk4xV5Jh+HkS3gEhtWZ7B/Txo79ZZjBf/PQ02T
         4pwUhUNZa/QI84o0xfdC27dmw9rCEjernX2hSjbWG2FliHDx2fJtJYVB+Li4nrXlKFmF
         6bkZ7RFg3ASJLRpCo2IXVh0hwhS39uvM9nDJvHjdh4yOu4e1LxbBia5rDcqjIl5BqNw2
         j3791BAkyVkOcz1bu3meYkXJS+4rmJlCog0rXhf5TO84wnDjVv7qDsh6iuU+IbQlTWeO
         NB/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVkU4sJz+PtBEr6mfj52zJbI8acQN2/TawVl/08jTG4bOUDFZo0mHccLXDyH4LpBDkFipUfamtB81h68kUnlY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkV21zzPFPQkD3toRKLS4B8k6oVMFe78lRbbo9k0ymDL1mEnW4
	l81Fs63kjC8/bWGqg+Gfmj1plfKRlXWd6o6vd5E+LAqWsc1wOdHrU+7T
X-Gm-Gg: ASbGnctna4mymEQgHtzietCR6fPQ512P6iBF5ylmw/LxPGw8l64GddVOdvm6EvlK3d2
	b8RN1luo6f608gMtRz7D0COQU0ntdLwI7/rT3E6OwX0Sl6dKrtjLYWdIIdg7N9Gqw8DDH5y/V8z
	Pj2c+4S6fihMuriwwkfSbFET+dmQATfqSHSZpJGcYem2F6V2fEkRlcWLK0s+l0zivJcmfjc38S8
	K4A19ePV1U3Y0jMtaq589mnNFv6XFRhkzqLDByJq6xK8+uNNS+MM/ep8s4cYeJcjfHPA5A/KXFi
	7g3fySrgs16zC3s11HAyM+mgzihd+Kq12c82AQDZ8E3i1U2g5W10P/HqaqY+f7sRnSSMPN+zvY7
	DxDVYv68FPDxWmbLiHlmvI7PMm2MdvFbRbJc6NDB0c+Xg+4+m5y8lHVIVTj+pp5jEzuL/dt08T2
	lJ
X-Google-Smtp-Source: AGHT+IHpp78yI4E7fmdg4RKErbV+vvTaqrD8H4+Tl6H9yDf3Xf2PrS+XAQqFQAashL3w1qH77cAnFQ==
X-Received: by 2002:a17:903:32c2:b0:295:5da6:6014 with SMTP id d9443c01a7336-2955da66415mr134706725ad.22.1762262018823;
        Tue, 04 Nov 2025 05:13:38 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-296019729b5sm26887345ad.10.2025.11.04.05.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 05:13:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 48956420A6A8; Tue, 04 Nov 2025 20:13:27 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Integrity <linux-integrity@vger.kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: tpm: tpm-security: Demote "Null Primary Key Certification in Userspace" section
Date: Tue,  4 Nov 2025 20:13:12 +0700
Message-ID: <20251104131312.23791-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=bagasdotme@gmail.com; h=from:subject; bh=zReFbCpQpq9hx7S5OuXnYnE+WALGscFOwncxZWVvVD4=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJmcv91Wn2n+Py0/tO3Haeca1lyzF8xGxueOf4uY+mTxt TshKpJWHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZhIWzDD/xCPHIYmWafsYBYr mejACZNcgm5f/TxP6+qB+8r/egznCDEyPJZj/BY664JLhHKtoetF1XUlqpLRncuTn5opS+tx3BN nAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The last section heading in TPM security docs is formatted as title
heading instead. As such, it shows up as TPM toctree entry. Demote it
to section heading as appropriate.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/security/tpm/tpm-security.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/tpm/tpm-security.rst b/Documentation/security/tpm/tpm-security.rst
index 4f633f2510336b..bf73bbe66db2fa 100644
--- a/Documentation/security/tpm/tpm-security.rst
+++ b/Documentation/security/tpm/tpm-security.rst
@@ -153,7 +153,7 @@ protect key sealing and parameter decryption to protect key unsealing
 and random number generation.
 
 Null Primary Key Certification in Userspace
-===========================================
+-------------------------------------------
 
 Every TPM comes shipped with a couple of X.509 certificates for the
 primary endorsement key.  This document assumes that the Elliptic

base-commit: 27600b51fbc8b9a4eba18c8d88d7edb146605f3f
-- 
An old man doll... just what I always wanted! - Clara


