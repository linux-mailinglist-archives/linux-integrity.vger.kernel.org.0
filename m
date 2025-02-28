Return-Path: <linux-integrity+bounces-5015-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D41A49FDD
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 18:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F8DF189B1D5
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Feb 2025 17:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789E927604C;
	Fri, 28 Feb 2025 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WM90rHSu"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928072755E9
	for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 17:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762461; cv=none; b=tw61N+8pu3lwh1Ue4Xgw2FXz4OeeEjU+Z0BlMDoKo9vgsIrR9JLd7dLxlpXXLvp9JGqo2jgK683UmG0mbZAHWLo/Gj4FjtUQ3TaZ6AI4PfhoWktZZgUcwLvNVhvT7q1Eg3GSRVIIcq9qlXVJoGm7Kc4vHyOKYXkLzVMWiG5B96s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762461; c=relaxed/simple;
	bh=aEEZifLiGL53ScaXp+CXWqgBL/vGbd9gqxOvNaB+tFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUazaUcD/huuSn8Jkm7cTl3o51Cl8dbH5ViqDv8ZtxAV1XvGBOMrAzHoLlM7YYu8qorvg+lCIEhTv+WW0PeJUyi8Eztg9djGDOcl9JvRzP1V+yRkdT/pr8OL2R+ws+S6JUP35tXikZZ7rqzTN1OGJ3BIbfladwW5mJ+XccjdTa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WM90rHSu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740762457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qecp1vaZHwIDMhKlcuRnrXpf0LcVGcRS2iGT3pazr30=;
	b=WM90rHSuHKM/RSngXIg1bE5wpxrRCDMFPTce0oG0xCBHGYj3yYLHhf0gQDaG+XO2thkSv7
	C8HO9HeDXcnJhtgUZN0+rfK3RQB5aCfU8mrD/UZFsOQ5KWTelwJOrdVKUPKDMdsP5BlJYo
	wMeGym7WjX8xiUYR6dgk4xSTUo15HSU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-NRxfIQ0dOYmznuJx-0NYQw-1; Fri, 28 Feb 2025 12:07:36 -0500
X-MC-Unique: NRxfIQ0dOYmznuJx-0NYQw-1
X-Mimecast-MFC-AGG-ID: NRxfIQ0dOYmznuJx-0NYQw_1740762455
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-390eefb2913so546717f8f.0
        for <linux-integrity@vger.kernel.org>; Fri, 28 Feb 2025 09:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740762455; x=1741367255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qecp1vaZHwIDMhKlcuRnrXpf0LcVGcRS2iGT3pazr30=;
        b=JSiKMVL0As33diibCQ/8/MbjbUewALkO/PIDn+eqwRdmwhTY4ghbwEnYZHx5QWY6lU
         QOdA5T5zEXvRNdv1T89rjodFgWBAf0T68YZATG8g1+hoeYAf1/nlng/0QHyh/UAvKvLi
         TPDHEHcLadHo8BhKaQHVi/cQg4KedCOmw6ttTW3i7PNPcaRVExmCXARWc3gKhOb7zFJE
         HVLcIc7HJSClx1SzFJVWFF2KN9wFIGPYcP7pzYF7WMa8PITpbRcqfv2TYAF4CzUlxrGE
         N1kGNUF8mjYIy4IZUT16A2CFSTb2aH54NsdZoZ8Ihp1rw3cyHeFlyDwfPrRZa3HzUJWC
         xJWA==
X-Forwarded-Encrypted: i=1; AJvYcCXbvhBtXBY0m1GyFSy+/OrPobydsrtzURkUrP2uu7PUywIVbKiq8KGT9vZoB5Z/dakRLpaNacdp8YqwPjy6Dlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydYmEKICWI98d+yILNLFb92CsqdLaN5AqrZisIn51Bn2gPHwWj
	jjlkPhzEyEwRi+KlGR7iFVNKlH6GvWi0G1Q40b4M1iTnkm1ezbld0zwXc/vhGHZ5WOlZ/WCW9oy
	h+Fs2cVNcTLyCyKCFzaZLgEBDBrsA88nWLmfzwoGE9lr+6De4lqVAUoIVttBUkqI79Q==
X-Gm-Gg: ASbGnctazGK4GRF3vM7zhUxT2fllkzknCiOt+CdAVqr+S0WZKqicgkYN1vaw+qBr8HQ
	w2iUNMtHlT69sugztz9dLuSR7zhx1BDlVxIJ9d7jFk/BHPYsqUOl12CTQS0PfGIVju2R3ps9O3C
	erC7/76biuGjoLGzwdKFoyOYVPW4ng7179uE4XVl9TnQeET554Mq2hORjoYXbCteKT+DGXRVRVv
	MJy/cwjizqfIjyBckBj5k+xwE3Y4weu0zRpuHT0iXvJS8eT6sxBWP6veqx4LBH4XX6UsioWeZI7
	l68juxREzJqXaL7InH4k
X-Received: by 2002:a05:6000:2cd:b0:390:ebfb:ab62 with SMTP id ffacd0b85a97d-390ec7ca2cdmr2939258f8f.4.1740762454673;
        Fri, 28 Feb 2025 09:07:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYTdPfOuJtFP7Q89g8LktQNvlTWyj6T8itcLSVDjI66N081G17gpijbMoIoSAJ3qAUH7gyfA==
X-Received: by 2002:a05:6000:2cd:b0:390:ebfb:ab62 with SMTP id ffacd0b85a97d-390ec7ca2cdmr2939200f8f.4.1740762453994;
        Fri, 28 Feb 2025 09:07:33 -0800 (PST)
Received: from stex1.redhat.com ([5.179.147.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a7473sm5847556f8f.38.2025.02.28.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 09:07:29 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	x86@kernel.org,
	Dov Murik <dovmurik@linux.ibm.com>,
	linux-coco@lists.linux.dev,
	Dionna Glaze <dionnaglaze@google.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ingo Molnar <mingo@redhat.com>,
	Joerg Roedel <jroedel@suse.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH v2 1/6] x86/sev: add SVSM call macros for the vTPM protocol
Date: Fri, 28 Feb 2025 18:07:15 +0100
Message-ID: <20250228170720.144739-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228170720.144739-1-sgarzare@redhat.com>
References: <20250228170720.144739-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add macros for SVSM_VTPM_QUERY and SVSM_VTPM_CMD calls as defined
in the "Secure VM Service Module for SEV-SNP Guests"
Publication # 58019 Revision: 1.00

Link: https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 arch/x86/include/asm/sev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 1581246491b5..f6ebf4492606 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -384,6 +384,10 @@ struct svsm_call {
 #define SVSM_ATTEST_SERVICES		0
 #define SVSM_ATTEST_SINGLE_SERVICE	1
 
+#define SVSM_VTPM_CALL(x)		((2ULL << 32) | (x))
+#define SVSM_VTPM_QUERY			0
+#define SVSM_VTPM_CMD			1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 
 extern u8 snp_vmpl;
-- 
2.48.1


