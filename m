Return-Path: <linux-integrity+bounces-9408-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE6FA2Z9+GkowAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9408-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 13:05:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1B4BC211
	for <lists+linux-integrity@lfdr.de>; Mon, 04 May 2026 13:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EB1603012859
	for <lists+linux-integrity@lfdr.de>; Mon,  4 May 2026 11:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A533A640A;
	Mon,  4 May 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rd6fk3PP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C7222CBD9
	for <linux-integrity@vger.kernel.org>; Mon,  4 May 2026 11:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892599; cv=none; b=LhuMRYWAVGtf0wjt5/uYIY71PPcLttuu228NAne0u0GGuHLSmUvOyUT9E9zO50rWRo5eV7obfu2tNO1tm5vDLkh2PBZHPaNu6QulqRAUt08Y9utlDCQYrJJi9ahU20aPc4fRpgHgZ3/gI2vWeJ++EGAwiCBtXWdCo8G4UheiYhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892599; c=relaxed/simple;
	bh=S0hr4yE9znvaDhmJfUfwVsmHGe3FQen/PXTfO7x3Lp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mmSSWE9heyq2QrzIZHoONPQJCsIrpOEkVWMWsOjKoUKvrpweo/7JclTU6iZDtaSKt//3D/GE1fIi0ih9CLVm0KxdEKHqyZotUROg+MOf/affpOskwOwyS/hDJ1sbYWAETAkTS82clppgUsHbmFeQWLYbFeXuaU8wabj4sIpN+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rd6fk3PP; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c796163fac5so2424632a12.1
        for <linux-integrity@vger.kernel.org>; Mon, 04 May 2026 04:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777892598; x=1778497398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSB0CVoDDyIAeZTcoKbzbwvH/JggAMqNd4O44+dOfSU=;
        b=Rd6fk3PPYKqV4tsdnZLXsZdNeqA2B1KirMvLwytfpcdvf68/wUbO48ypoCLWhrgBuA
         EwjigeiagRg+fDY93dV1xgwh5JhZoGef07ea+Yy/7atfyxvsC79gi8lkBr/yhDv8oBCV
         CPcaPdhOx1+tiOllJtJ/XZ0wSNWiTlfy39zmT1I4ZaDv4FMvcm5WxAYTSf+Pl7hcKMFy
         w3AnAkQSyjE8w0a4pIqH0/o4cJCqJTL2uEFyFTYCf6R3HXNzAOf3qNa4zK3vruBjCfEp
         fMbWNueU5RKHvxCAyUaROJ1iZGYr3a06l2CZwTZ3d/YCUM5YTR2wK16ZRsoVr0E7ILK8
         y5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777892598; x=1778497398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sSB0CVoDDyIAeZTcoKbzbwvH/JggAMqNd4O44+dOfSU=;
        b=gtNhOiGNhH5qwVN2GfyCC8L9+2m/tBvVg9ZVQGq1LnV9WEZi3W8uZG74wdNSBs3fuz
         XbxrPjRI8qF5QFLxJe5SaQjlfSbVezg6Y2Re4ZzBbFA1IjKQ8h+vqa/JvnwT8+2X+XPC
         cELXpAlPrGdmCQazR7GJ5cKUHlQS4J3mMvWAjGRnf8jM1x7O5x8RTSXIM3IYevfSVwp0
         wBXGE06ED7cEosHhL7ZcaTxFdorpaUaCiqQZ5lIrzsRUbs0XgSnDQPQMLZqO/Bx/OCnb
         3/A2nDEq0YWLme+qdCsHFqi1qAG8wHTUUDYLDfrylqZtmNP8U3xciHdEgb7kF0pjdSsV
         y/Ig==
X-Gm-Message-State: AOJu0YxfOEw+RUPd0meVmIduS4EvjZdlCCfF17K5RXw5EV/Y9q1HbrlT
	N2KNGJZKqRQsL6h5XNINIeZRX8N7Njj1D5Wn6xEQgFq/bGeQG/CGeyHv
X-Gm-Gg: AeBDietWDNX5UCPAtYXqOOOH8lGA5u8ANK3Y79THwGwqDPmJYoTDHz8C87w3lyUhMlQ
	tghVJ7p/CEOY7dIoY/u7/QZY70GEOmQ5WdnE02C+7oTw67AaBM1aNgNIVzSpQ8yj95DpxZCnTb4
	ur7QGU0RAGeum1qKkMTGiyAU1EBKrbbssPNHN7+h5Hpa/rrTFiWFEoXWOpepimrlLZK/uUHpQXH
	5aCXyWTahyWm+tGq83sdLAVEwMXDgQwGjBhJEkxZgRnBgqHpdWakV6kqzmAA4eOibdO5W6nGxnU
	eLFT57OyeGWn+uCtgiVOWVnhaHL0vE/F/rD8gTL3aHvypwYWJY8pCSG37uXkDzuNyZlpQ2+zkvD
	6XmcpVKG0OTcSb99yWx8R18zrmkTCt+HbM2RDBY8CmUp0EVMZsHH8F+gOMJk1KFx831EroCnabW
	zaGMqsqsuhvtep40itjHTwMjloRCu3WAYyWKA19vXiEDLmERjO1EbaSKQ=
X-Received: by 2002:a05:6300:48:b0:3a2:dd7d:b8aa with SMTP id adf61e73a8af0-3a7f1adde45mr8746470637.20.1777892597758;
        Mon, 04 May 2026 04:03:17 -0700 (PDT)
Received: from kam-mbp.juniper.net ([136.226.252.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158bcb99sm13138618b3a.25.2026.05.04.04.03.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 May 2026 04:03:17 -0700 (PDT)
From: Kamlesh Kumar <kamlesh0hrs@gmail.com>
X-Google-Original-From: Kamlesh Kumar <kam@juniper.net>
To: stefanb@linux.ibm.com
Cc: linux-integrity@vger.kernel.org,
	Kamlesh Kumar <kam@juniper.net>
Subject: Re: [PATCH v3 0/4] Add support for ML-DSA signature for EVM and IMA
Date: Mon,  4 May 2026 16:32:54 +0530
Message-Id: <20260504110254.88568-1-kam@juniper.net>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260416154039.1648083-1-stefanb@linux.ibm.com>
References: <20260416154039.1648083-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 07B1B4BC211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9408-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[kamlesh0hrs@gmail.com,linux-integrity@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On 4/16/26 11:40 AM, Stefan Berger wrote:

> Based on IMA sigv3 type of signatures, add support for ML-DSA signature
> for EVM and IMA. Use the existing ML-DSA hashless signing mode (pure mode).
> 
>    Stefan
> 
> v3:
>   - new patches 1/4 and 2/4
>   - addressed Mimi's comments on v2
> 
> v2:
>   - Dropped 1/3
>   - Using "none" as hash_algo in 2/2
> 
> Stefan Berger (4):
>   integrity: Check for NULL returned by asymmetric_key_public_key
>   integrity: Check that algo parameter is within valid range
>   integrity: Refactor asymmetric_verify for reusability
>   integrity: Add support for sigv3 verification using ML-DSA keys
> 
>  security/integrity/digsig_asymmetric.c | 152 +++++++++++++++++++++----
>  1 file changed, 131 insertions(+), 21 deletions(-)
> 
> 
> base-commit: 82bbd447199ff1441031d2eaf9afe041550cf525
> -- 
> 2.53.0
> 

Hi Stefan,

I have tested this patch series on x86_64 and IMA signature v3 appraisal
works correctly with ML-DSA keys and appraise_type=sigv3. Signature v3
works with appraise_type=imasig also and I think it is intentional for
backward compatibility of ima policies.

Tested-by: Kamlesh Kumar <kam@juniper.net>

