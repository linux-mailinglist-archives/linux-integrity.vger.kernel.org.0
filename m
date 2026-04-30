Return-Path: <linux-integrity+bounces-9393-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNg/G5Ls82kV8wEAu9opvQ
	(envelope-from <linux-integrity+bounces-9393-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 01:58:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D824A90AB
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 01:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1F7B302B392
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Apr 2026 23:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F8C3DB632;
	Thu, 30 Apr 2026 23:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="SpY7bXE6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B063DB627
	for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 23:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777593346; cv=pass; b=tkfG/tC8f5v7TVlh0nto5d/2PcvW+ARXVnCiibi/lLda77SQGl7fZm911fQcXF0GGvAqXPyUjgBxa5mKXcFRqKQQg6zE48eDLRlV6ibRmq+lB/V2iyyo9kjrEE+7RLlC78QZmpL9MQauSuwZd/eMBh3f4Jc8fEGWNwjUu8FKGl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777593346; c=relaxed/simple;
	bh=I/Xvk0kFRp/VJEf1Enq2JPilCunZvvkT4+zkK+gT3mU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UMULMXr89Ku4W9BfI8VQZBakwCKCgUCH3Ae7aUtW47Ah9vVEnoiDTh4ezkROIcHo0MMglg1+LgkFDVfnCn2iWCDrKzVHGgle3v845MgumXwWbH6VjgtLmvxGXwZC7XbifemHl+um9b2fvStF4/+8rC4ijw5JaIxkntQB8Bql2xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=SpY7bXE6; arc=pass smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a5800772f3so10356026d6.2
        for <linux-integrity@vger.kernel.org>; Thu, 30 Apr 2026 16:55:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777593343; cv=none;
        d=google.com; s=arc-20240605;
        b=OO2aw/mAuBlHIvksqqEGGsyTQcaVvzNKZvUtUv9Ozc8bAIv7TD0pBLiHc4A9MQl/ie
         1wkZ9hGZ8NLzGFsD7sJNfxZ90H2FxtpM9+Xa2fad2xv8xVObtRzwR6l9QxwkB7DnytDh
         aJG4HjL6sNfl9hYdW4dx1kMg7hlb8O6Hp8jLBDpxMxIMUZ8ZFVhaPFblc4zoGhhDSawX
         mFyl3KDQw+F4r+Ki06VcTnJswpBQz8+QMBp8ILPUJ/n/kH8txYrnqcHGer/EY7UzKH2t
         zC72xheJBfOAk+al4k0n3bRKso1jEnjLxlOXeAgN+7TWpQrz//8yr3plA9ZzHwdhML/m
         uvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=A2KuirxYNoulHkRIHYtJjt3AlbCi8CmFBeMO4GA/2GQ=;
        fh=bm7ylp0WCIGBBPMNvqQYfKRKSNstX6OGJvaOB1okyzM=;
        b=IgLxbAZ0AewQAaIwXFC7dGtQ0+78xw+dLbJZxlJ/SPNP84FngC9ye4e/7yg2U1qbud
         ty38K/T79Kca9D6ROzI8lQtujq522kmUFGzhx6YXtJPVXCavhqBC5cQcuv9TA3sFtdCo
         ly7Vw1syV8ROa9rRY3MJpQ8RQnXTdedDqflHRaqaWqShqAlrmHyjtCUmoMGF1GmEo36t
         XNRQOg7XwYiWJgmOBtbiYnFTb3Kq1Tv9uUYkP4z0bFAUehbZh9qOQZhjAUqA4lyC5a3V
         TujYsG3LAHpWGimhdDTs1iZfB0OYBRxD/Lf2C56hird8JnJtDzw06p9mGsYci7lIJRb8
         ttlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1777593343; x=1778198143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A2KuirxYNoulHkRIHYtJjt3AlbCi8CmFBeMO4GA/2GQ=;
        b=SpY7bXE6Lr5Kq3CBigxv3v4Wcms4t20lCXvqQRm7AIfmFnon69eeEjHYNT0a9pu3GH
         4cj/FpVMred+4BtvPVNIHwDsne/5L5N1o9sogelKcaMoTb5aQpHx7v/CoWLnYM6sRGJr
         /rwxAGXzYFBtdNqN9vO2lIJ3ERE8EqJ2G/BEhVh0I+ml4dQGye9VrltNcQL48oEmBESA
         ZiM+hWLRMTLNHPIIqiq3NU2IZ4nc14071byduVLuFNzf23d/Lj8rE0ZMSkxZEHgxjQZQ
         ftHU9o+0We1ikCT/wU5TtwJ/QmZhGTawUIBGBBpVJ8yAVao5lVzYukdThhcYLAnq2uB5
         YREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777593343; x=1778198143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2KuirxYNoulHkRIHYtJjt3AlbCi8CmFBeMO4GA/2GQ=;
        b=kEyXyS6IMdfMdlZe//bIYwQIUsMixNaSVmcsPQeL8koS0c06letOxzInmqKu5jQ9b4
         PkEzQUwtDIMNl/YygPKfavWcV0EHokTmGRMqJPMfil0Lart/MUi6TCUSzq01MGPIpYqj
         P4/UYKJ+80P5+7ZrVbr3xKP0TPaiaDoczpfrh32GE740a1kWQ5AsvdvlfBO33BYr/bKy
         0YnSXL38SuLqIJJJBy50ky37YGosxx64V/wK2doBbh8GZPTRw4R/dUeHKdZ+BYfS5Zn+
         tqhVKn76la/7ik5y///YOg2eaJ0YkMdCSGc8+azP/FA9kaWfmkSCj1lGFSZALhjXlgvf
         In1Q==
X-Gm-Message-State: AOJu0YywHEHL8HB2xh808SVWFLPZHL7ob5w8lEyf70UuoDkOJmAp1yFn
	g728mrMn0r9a+Q9pcYglSKfH/GNWQK7FEiAIPrmo4DibR2o4PWIJaw9VPjAr7CtcqBcDtiIINaa
	bP1Fdm98eg83bZQp3cfKj82L1cEbnFBZleTo0AJXBj2UztciNjcaoEVPQ
X-Gm-Gg: AeBDietR+EgheqAjJKC+U5Brtb1RUgPIvB54eBuv2yaNNqoarDOwaQFnIZtso+V5Nuk
	2gptjgKJWQRro2mVogisRqFOU17jGrSK1iB9ggHnYXautgYvueFdellWMzuQTYLtEyKfbiSeySu
	37IdgO4zVW711/ARVjlogCbwJKGPc5MfP+LszvtbvMtQuENoXahOiWIyEhSWzX8Uk69U9FjqZTY
	kZ3WtBKAuXFChIsRQheaDXNLYHIjOGe3FH8KGt2ldTD549VIM+O3fkZKeYgEEHdtyO5WHKVHxGW
	fnJ4SShlpY/dF1N5AE8X1tQS/LIDJZyLlWXurKQwXCy7jIZnKQ==
X-Received: by 2002:a05:6214:c82:b0:8b3:ecc1:db29 with SMTP id
 6a1803df08f44-8b3fe7bc8d0mr36065876d6.32.1777593343260; Thu, 30 Apr 2026
 16:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Danny Hu <dannyhu@arista.com>
Date: Thu, 30 Apr 2026 16:55:32 -0700
X-Gm-Features: AVHnY4Iu67wCogOWcArQ2iej3YMXbTj24Ime0FXYYyXF30MOwHzSar2jYZunNtY
Message-ID: <CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
Subject: IMA: Avoid redundant rehashing on stacked filesystems backed by
 structurally immutable filesystems
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, Sahil Gupta <s.gupta@arista.com>, 
	Julien Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D3D824A90AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9393-lists,linux-integrity=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dannyhu@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arista.com:dkim]

Hi,

We observed that IMA will always invalidate the cached measurement
result and re-hash a file on overlayfs stacked on top of squashfs. The
behavior was introduced by commit b836c4d29f27 ("ima: detect changes
to the backing overlay file=E2=80=9D). We would like some feedback on the
proposed direction we are considering before sending in any patches.

Problem:

process_measurement() in security/integrity/ima/ima_main.c includes a
stacked-filesystem re-evaluation block that clears IMA_DONE_MASK when
the backing inode is not IS_I_VERSION. This check does not
differentiate between two distinct cases:

1. The backing fs does not implement i_version but it's inodes can change
2. The backing fs does not need  i_version because it's inodes cannot chang=
e

For the latter case, squashfs being an inherently immutable filesystem
with no write paths does not set the IS_I_VERSION flag and ends up
paying the cost of IMA hashing on every single IMA appraisal
operation. This is perhaps overly conservative because the contents of
squashfs cannot be modified anyways so the cached result will never be
stale.


Proposed direction:

Add an s_iflags bit, potentially SB_I_IMMUTABLE, that a filesystem can
set in fill_super to indicate that it is structurally immutable. IMA
can then leverage this bit to short circuit the stacked-fs
re-evaluation block and trust the cached appraisal value instead of
forcing a re-hash. A motivator for this approach is to follow existing
precedent. IMA already consults s_iflags for filesystem facts that
affect appraisal. The SB_I_IMA_UNVERIFIABLE_SIGNATURE flag is already
checked in the same process_measurement() in the block above the
stacked fs re-evaluation.

Happy to provide more details or clarifications if required.

Thanks,
Danny

