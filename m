Return-Path: <linux-integrity+bounces-9398-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BdhEpLO9GkYFQIAu9opvQ
	(envelope-from <linux-integrity+bounces-9398-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 18:02:26 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E1B4ADDFE
	for <lists+linux-integrity@lfdr.de>; Fri, 01 May 2026 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A77D30075F4
	for <lists+linux-integrity@lfdr.de>; Fri,  1 May 2026 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9EE3D9DD4;
	Fri,  1 May 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GBkQlG3z"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846A53DDDCA
	for <linux-integrity@vger.kernel.org>; Fri,  1 May 2026 16:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777651343; cv=pass; b=S80QKYDUFrOJDNsjB5n4nMZ6DSOh17nCxerzARyMsJU3b45EwQNlBRVXNctM8gBlBLrfc3lkSnDw/L/UWaGUkV5tj8Symz+pAS0es74oc0Vwt7Nghq+4WiUhRf3jEv/Zemxef56SdzwhxmitSgK39roC07AX2TQyERXw/92jq/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777651343; c=relaxed/simple;
	bh=u+7aMpeIjawRKyYJTPaSJImwdjq6o2bGlpmgyjkEGiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgppP+QbyfUKyQsgEzlQpvQa2BWB047VwIEEnGUxrWcavRY+zLcECBqVw/lFUHZgLFZVBVJWhdfje72yoa+DUUTdT9BRolapboJ4HfCx5l1KLCpKBbn3Y08xAcWoj3sCo4qAg6c5ToW11D2/06WtuDidctEmIgK/0eJPFVz8C/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GBkQlG3z; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a40cfab24dso2214337e87.2
        for <linux-integrity@vger.kernel.org>; Fri, 01 May 2026 09:02:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777651340; cv=none;
        d=google.com; s=arc-20240605;
        b=CJeuUimYbKOsI4phANAu/z4qe8fVfs86JiSFiX8pvdauC382MT/mySS75VXJg5YLjY
         6eSpN9oRc6ffqHsx7JUg1sAzq7QcPLnCFDJY9UnBInx66a0LLEmjshLR41Ybj6uxI3DQ
         Bw9r/ypxMK4OFBQlAn3OFDFQYPC2Ldu3IpNuN5jJJatcMF97jXvAM+t8ioooE0WGgSgo
         A36sSs66fZMnv1j4hVjSSMU3WpF7f9zYq0ZkDhZMw8e5S076RNuTvCKFVRneq0pIR8uX
         guF+yA9Rcycg5uAiaU3er6sNoSPulvFJ/JIJDL0TVITNnbWcjMdNHDaTIZkRizgCIGtw
         kgSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u+7aMpeIjawRKyYJTPaSJImwdjq6o2bGlpmgyjkEGiA=;
        fh=/gvalNN1ft4hlc/CzcUfPBT+MfBxeqOZl5okSsjAyrc=;
        b=gBHSSCwrafuku+GXRYMm6ngW570/86jcNWXfyFrW+dCwr/WPHPv8wLZu/zE4WELZ8w
         udF/BEHslH6NitC6yzAASTEMvKfsXE13BtZED86ut114YgyZg4uAtQi63UedYQdLoKFU
         c/bZ/oCZOETO/T30+hWw6efryvQq8VlARry+y6hIMQpeyxT2gTc9iZtTCfJ7P1M6sMQJ
         C3/RA3uxviHrmK54xDEPY7j1TF2pIYgdV3WIlPtd1ZXFF7rV9iuhctKVIgusEFykd9US
         dIO9vZ0ApnZNe5/qb5qx3b8WOYRxkKVJEufA5vrmsilSEdVD8NtYqmLzU0ez9dNS3tFz
         dT5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1777651340; x=1778256140; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u+7aMpeIjawRKyYJTPaSJImwdjq6o2bGlpmgyjkEGiA=;
        b=GBkQlG3zeO8YBTSl2kZ1EiEyB5RlO775PMTTdy5I2n0fEsjjrhhLAvvMCRdY5WB3RG
         mS2HgkVj2irnVNnBatQDJ/ENo2YpMjHH58qparYGnxk7lL9yi9bdyKOtdLz5ba8B68k8
         QRHnk/8wfS/sfr2U1b5+7sGYYOmMmJaTwNsX5RSbXnHsQl+BhdANUG+1BwJxClwmSEZ/
         CCxzzfqhF6CcjjFxyflpYps8Htoz85GPd7Xn8IMmhP4FnDILDv4W8NSe0gsXqScZafX1
         6rOYE7jXm0y4XXln6HHHSH7p+7lRudFWauoZ3bzJVV8opN9qucHwLQc49L8fZ4SMRIHy
         METw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777651340; x=1778256140;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+7aMpeIjawRKyYJTPaSJImwdjq6o2bGlpmgyjkEGiA=;
        b=eAtqzDCEkGTAVE6mNo/rrLRnK2M1j4WFvtA3s29AeMPrQaMbA5kE06kU91rieQnp30
         cDnwfBVEKX0LqsRlnIS/V0VPgNRu3z2pxB7Ogw4OyFyGW92068pvNjzSqNIS7lw1Mnp9
         1A8pwAmS/Xc/MrhK3NKXrSV2DjuX0nOxTrRliFH3BB6UgCCNBqlx8+5SFrOsK/HmgWBJ
         nT733qWUc9qNH690FLUmNzcp9ecTPAEgoxYsPI+2WEq2rZJ8dYSorQU3FjuKF5GyEfrI
         7CfR9MwFUkJYFO6H5tZ9XW2zGV8npLISEiK2Kebsq9SEeNaE4d7mh05lFnwtPwwxkXrP
         tR6A==
X-Forwarded-Encrypted: i=1; AFNElJ8Zh9V+u/lCDAd6E94xBeiQrJXyWlgJZ1iqKXm8fsKs8+9uEJTIwdVtl2RwkuGjOz0aJ5G3wGJ+7eV6jJmX1G0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/N3ZAeyeOVmn9YpOUpWmDKeBfepV2+imreM+1AT1hR40DM029
	Y094W+R/SPJG/JENOxy69koOnEKmYByV8mHm69BqafBq1aGHEei8qvmz807MHa7l0fZtkOpiShg
	UVyJ+o6nvxK+LjXj6ugFoLpRGbqACSLWjLjw0Rfk4
X-Gm-Gg: AeBDievor1X8l/qwRZOZSuaVUR+W4wYbNV2EStVX4kfs4dE7yHJUqGHPmXL65G7VBG1
	i4i2rxsmuxKUxocaqOKovzWNXGWmCwUppQv60x1mKEaPmuyHBn8a2GWLf07NhbE60nLTbydTwX7
	8OGJcRHQvsO8a+dSz9eCp+n+MM5TxmHIlxgYyTqdZMmOf2bSYzlqNeWG4qPSawS6BLviGJWwkBR
	NIrilOs1kEXgLNcejcLOirc5dUVRtotPdpfP9M0mTH8QVQE5vq9/buTQfR0lyn2XKQWZKPWnrc5
	r/PQoVzryUKTzulM6m55GdpGHHYutYZOjkGLUTPO/aovjU9CyDp5
X-Received: by 2002:a05:6512:1256:b0:5a1:3400:f937 with SMTP id
 2adb3069b0e04-5a8522b130cmr2717842e87.7.1777651339641; Fri, 01 May 2026
 09:02:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFn2k5DJNv5SDsx_-odHd3sB0Fw7r8FqhO8fWdXrraZn_vbpDw@mail.gmail.com>
 <2b3c93a69e70b6fdf637bf9fb921d5e737a79e8e.camel@linux.ibm.com>
 <CABEuK14__XuRO2KOd3w+qx5_nw4iB2yPcF2R68a09A4hcJkyFw@mail.gmail.com> <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
In-Reply-To: <4cbd1b20680e2dceba8870f62f2081c333113192.camel@linux.ibm.com>
From: Sahil Gupta <s.gupta@arista.com>
Date: Fri, 1 May 2026 11:02:06 -0500
X-Gm-Features: AVHnY4KDJxIk51Cz9oANz2NzNJmHlBBQ7VknO1NUbFcr8Eq7Ralfs9o_LsbtOo8
Message-ID: <CABEuK16D7RB71JTSxCjO3jFY70+yNugdjM+foJFnzMgsCH7tcQ@mail.gmail.com>
Subject: Re: IMA: Avoid redundant rehashing on stacked filesystems backed by
 structurally immutable filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Danny Hu <dannyhu@arista.com>, linux-integrity@vger.kernel.org, 
	Julien Gomes <julien@arista.com>, Pierre De Abreu <pierre@arista.com>, 
	Kunal Bharathi <kbharathi@arista.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 81E1B4ADDFE
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
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9398-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[s.gupta@arista.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arista.com:dkim]

> By "fs reconfiguration", do you mean remounting the filesystem? If so, the iint stored in the LSM security blob should be freed when the filesystem is unmounted.

I'm a visitor to VFS code, but from what I surmise, a remount doesn't
seem to be equivalent to an unmount + a subsequent mount. It's clear
to me that an explicit unmount would eventually call evict_inodes() ->
... -> security_inode_free(), but I don't trace such a path when
remounting it.

Sahil

