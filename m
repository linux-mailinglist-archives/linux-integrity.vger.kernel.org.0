Return-Path: <linux-integrity+bounces-9342-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAZzEYtd72k+AwEAu9opvQ
	(envelope-from <linux-integrity+bounces-9342-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 14:58:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2547300E
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 14:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 428043001054
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Apr 2026 12:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9736C597;
	Mon, 27 Apr 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQnkbKHc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347273AEF2A
	for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777294672; cv=none; b=dZxNmEjL2IT6ZK8n5kfuIIvJyKTNdLz1CE2j3I73J97hQrsGN1Vad52oKzQK5fxZpVdKWHouxt7gZ1tK9q/YR9Y8XD3ay721ID6N7GKsXGrMrX5s0mfZljvIpT7gNsbwifvc1DrEYiYmbeg1+h3C8WbIfGi87uO1L4DFnsnAtNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777294672; c=relaxed/simple;
	bh=CMqmqJqzZ3v6xctrrqVeRin9xgctBl92jwRK1CTauYk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ccD6dMJHn59A/ZpL795ZKWJ2Gv3wV1ufNnQ5nWP18ghwGKF+RTGJLNpwMSyYRSd/JHPNczaYXAixidrR11bK7b7vbbRODjRrtApIxVsZYghXyVEtXbZock9ddze2+FM9/7ZwyZ8/P1eVEdhHokqerOQeFTz9FEsuhI+8sY3b3RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IQnkbKHc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c79662bbd2eso6977424a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 27 Apr 2026 05:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777294670; x=1777899470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dk7KjKKljj1sfAoYWEJmtVuFN433zTZuLlQ6ddgzjQc=;
        b=IQnkbKHcBcCPqGXFR4veOCgUJ/bYnLbaKl30yCzhj+uxMEdNHvjQ7z2SCo2DyU1/0+
         JEaLSlg1nXEx0AW1fb6AbnfWPc2IcszKz5gOpqx3ML9+dSDI+l0HXHozMgPgRU1zjN7Q
         x3ovdxoNdsGZIjWmxCEHsKNDVJp2C/MKDZW6IyL+TUZxMc7ado/owU70l+ZReKQE5qtY
         gsEhOn8Zwc9Xpnw+O9a+DZUzPXXit6NzNVI191A8nNfOFX5DrJaQHdcoAp5pwMuYHNsD
         trUR7btEErtUc3urXmmGX1xaDMTsOwzVWIjZ9nGATbb0eBk0qulimFjKhSRvB6UJ1Lz3
         z3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777294670; x=1777899470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dk7KjKKljj1sfAoYWEJmtVuFN433zTZuLlQ6ddgzjQc=;
        b=AwYM68ldvq8bU7dZFp8FHFP7mmyvfY8Cf3dZxbE1wEJdSU6UUA6tOzeIicJbXNH/CL
         7QjlSGJzwXHY9RL/gEU+HJRXVqLbaFpK04444A+ZuwhUR48oa2Aop5WCSa+01Ak9K0CN
         88vH4hmEGysJzFPy2KkFKYUCPOReyzNIP9G+WmTmA+qafTkZOotKLX1UnKvEOrn5Gdkf
         P45XQSBKbAKOY1xkFnIdYPxmPqqBpiT4eJUygMTD1VdSaiXNScyakkdc61XTF7hqKzoE
         QdUN7ucE72TyVn5zdDI98prpuhCsmGKOFFIlHQL//NO8+rjxiayM9b0K9Pyd3Mqwx4jP
         wYPg==
X-Forwarded-Encrypted: i=1; AFNElJ/D/upiQsPerPlYjFlQREH7dqRtEMbOv1ht+S+tzZbouCN3HgsckQp1OA9nKzT0Vj//K6V94/nC9a0do0hbeKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRptILTOOzCNw4giIcknJWbKg22ok3uYuhzGN2/Q9CwgwnLkd7
	/UMnD0+5r45s9ULDBVkfxX8QTSkiQcUAFWj2/6cDqSvrDSqy4UBQBdCZJBFnbV/9uFU=
X-Gm-Gg: AeBDieujx5vMjvnuzd0WWM4DBgSCL3K1Gf46aLOKwLUOS23/Jw9t5xj51dBL+fEZcCY
	N92FkxKNIOI1DlEkT1KlF6OOMkkRDg5hZlgByIICXNm1nGpb1ONNcB1GVp5/m8AX2kNN+m7P1Fq
	ghg5K2t5Xra8dSgsiomL5MOiqd946Ce7Pa4sM+TKKgyC68ukRr7QKQcWOxYpX3V3mdllK2e8Ia4
	pZDHRT2wBZFBqbKI3XIfjT5wcUccGQxxIpwwHeuIDJWhL4MVmK+/plWlwCTpM1QKdahFGV7uXub
	OOxB+6Xx3D+0SC3TWBCdg7r9iMZUFIvKN7y7aMHMF7w+y4Gcvmlpdi3aYfHxuhTkbWkIir9laom
	rGm/AaCMdeyHlolB2unDWNDgn/lVgwWe2y8ngy3djE1wb8aD6XQe6wIhPFYzpQVuhA7fsCp9dfb
	zNMJclGhEvRwomX309apK0ApW39GuxGoijIPoSZN+RCUGUWLA5QO/l8DI=
X-Received: by 2002:a05:6a20:6a20:b0:39f:24ad:ad00 with SMTP id adf61e73a8af0-3a08d68d780mr49637001637.7.1777294670409;
        Mon, 27 Apr 2026 05:57:50 -0700 (PDT)
Received: from kam-mbp.juniper.net ([136.226.244.206])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7976f8f370sm25391485a12.7.2026.04.27.05.57.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Apr 2026 05:57:50 -0700 (PDT)
From: Kamlesh Kumar <kamlesh0hrs@gmail.com>
X-Google-Original-From: Kamlesh Kumar <kam@juniper.net>
To: zohar@linux.ibm.com
Cc: ebiggers@kernel.org,
	linux-integrity@vger.kernel.org,
	stefanb@linux.ibm.com,
	Kamlesh Kumar <kam@juniper.net>
Subject: Re: [PATCH 0/3] ima: add regular file data hash support for sigv3
Date: Mon, 27 Apr 2026 18:27:43 +0530
Message-Id: <20260427125743.35245-1-kam@juniper.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260324203929.2475782-1-zohar@linux.ibm.com>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58C2547300E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-9342-lists,linux-integrity=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kamlesh0hrs@gmail.com,linux-integrity@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 3/24/26 4:39 PM, Mimi Zohar wrote:
> IMA signature version 3 (sigv3) support was introduced to avoid file
> signature ambiguity. Instead of directly signing a raw fs-verity hash,
> IMA signs the hash of ima_file_id structure, containing the type of
> signature, the hash algorithm, and the hash.
> 
> Pure ML-DSA calculates and signs the hash directly rather than a
> pre-hashed digest. To avoid ML-DSA having to re-calculate the file data
> hash, Eric Biggers suggested signing the smaller ima_file_id structure.
> 
> This patch set adds the sigv3 support for regular file data hashes. A
> subsequent patch set will add the ML-DSA support.
> 
> Mimi Zohar (3):
>    ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
>    ima: add regular file data hash signature version 3 support
>    ima: add support to require IMA sigv3 signatures
> 
>   Documentation/ABI/testing/ima_policy   | 10 ++--
>   security/integrity/digsig.c            |  8 +--
>   security/integrity/digsig_asymmetric.c | 58 +++++++++++++++++++++
>   security/integrity/evm/evm_main.c      |  3 +-
>   security/integrity/ima/ima.h           |  1 +
>   security/integrity/ima/ima_appraise.c  | 72 ++++++++------------------
>   security/integrity/ima/ima_policy.c    | 22 ++++----
>   security/integrity/integrity.h         | 14 ++++-
>   8 files changed, 115 insertions(+), 73 deletions(-)
> 
> --
> 2.53.0
> 

I have tested this series along with Stefan's ML-DSA patches [1] and an
additional fix [2] for ima_get_hash_algo().
With all patches applied, I am able to successfully sign files with
ML-DSA-65 and verify IMA sigv3 signatures during appraisal.

[1] https://lore.kernel.org/linux-integrity/20260405231224.4008298-1-stefanb@linux.ibm.com/
[2] https://lore.kernel.org/linux-integrity/20260424110751.5637-1-kam@juniper.net/

Tested-by: Kamlesh Kumar <kam@juniper.net>

