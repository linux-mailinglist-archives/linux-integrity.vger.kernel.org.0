Return-Path: <linux-integrity+bounces-8430-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MdcLIr8gWk7NQMAu9opvQ
	(envelope-from <linux-integrity+bounces-8430-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 14:47:54 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B7DA1F1
	for <lists+linux-integrity@lfdr.de>; Tue, 03 Feb 2026 14:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEE4D3077985
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Feb 2026 13:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5655F3A0B0F;
	Tue,  3 Feb 2026 13:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="inAvxD4I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rqu5iPlQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F222B3090E4
	for <linux-integrity@vger.kernel.org>; Tue,  3 Feb 2026 13:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126332; cv=none; b=Y72DyGxXmYAgSAYGcTPBAQb1CHevnaZ6f8p3ya30bqM6571kLssVa6BGCiW8odmlvdvr1/Jhj+1gMe94qvQltTh0Wv4M5pi8pgA1meR1GTpViFPteUKkwsTTfqBknwzx9pbznRo0NHbLS04cmQwNo0YtOHF8/ayR+qkI9IOiugU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126332; c=relaxed/simple;
	bh=lvsYp3H1+gWA5AeRRPJ0wwKeu6rWLpQuDQcZLr3Mi9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUyEawRF933iQX0SZZyQ9/7koONO0dje0m9N5KPof6l4PNZ8mJ3qh+WWD1ev/FAwCBCuLL2g655M0ctbu3fJ6huGGzAlwaozGvjkyiK4TVbYfD9ExZgNgUNs4S0Da/ixsJRuCLFmxs8jJheCO5963GfDeGhh0d2WQXnSt7IVSu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=inAvxD4I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rqu5iPlQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770126328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xr4CwAN4WPxPbrE6dktzcw7EThzmA9unHQ46Jjzl26E=;
	b=inAvxD4II958xy7wvAEb8srkRplbvEHHSqnZATYyn62UP+7zxwYkENwT5PkgeZyDQSgh/W
	dR9nPXLXj/EW81HqiNhkynYzc3tMUtFMDPM25Tj36XZqjHaR3S/OSmVCntqDxyBjnM3fLl
	95uYAc/aMC9fT0l8cmDDVhBKu1P/fwc=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-cBT7nDIYNyaP3kRwTWzG0A-1; Tue, 03 Feb 2026 08:45:27 -0500
X-MC-Unique: cBT7nDIYNyaP3kRwTWzG0A-1
X-Mimecast-MFC-AGG-ID: cBT7nDIYNyaP3kRwTWzG0A_1770126326
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8230d2a470eso2804005b3a.2
        for <linux-integrity@vger.kernel.org>; Tue, 03 Feb 2026 05:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770126326; x=1770731126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xr4CwAN4WPxPbrE6dktzcw7EThzmA9unHQ46Jjzl26E=;
        b=rqu5iPlQNeZgfwkBgBcPl4OqyrxTj0B4Xh7XrAAttNb6f+0RzlZAtDqqCSK+tQ7hcI
         5EITxg0JLEkhOf+NmgHWfL+wmT019Pjh+A6wtS0d/J35asq2Y932SovoY9gUguv3C338
         eglppUcTPR/0QWwvAtYFfJTXvVmFpIm6pXYdMLs6fsu1Ig8vU7Md9LHgtkecnXS31thx
         6a2bC3jlxG1fojxOazrh1vC7POzNIBjj9//GDFdbQH8TjIFwk9F670yKevh4wEi8XLF6
         rogfyDELwhiqJYm3Fedy7CUcL1GeZXGQMKe/h6RK7KatQMwjwWecvvgYicVoOy9SwgF4
         UEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770126326; x=1770731126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr4CwAN4WPxPbrE6dktzcw7EThzmA9unHQ46Jjzl26E=;
        b=jhmNpZC+4BpblcwQPgM3PrSfkkjS+5DhDAz/IcI+ZwUKkVA+ivtSRS+fm3tJhXTCOG
         67/TlGYkBvIyid6RhtacGdeZ72DLm17+M5TNQ7eONFp3JPQ4oRXsKUVDXACTxZ/ak+sh
         VRV935XK7v+k1ZixnigpBjbq6D58vDgNIqcc3dPYDi2MdKaGsrKltv2lRyKTBtkN/12Q
         eDXqHcIX/i3xn0+S5GD+1qcBg75oRpHMYtk8ZlEwxy9C5WiQX+W+2ZEeevy4HKiY+jCy
         /HKqGi/P6aLkHUC2Fxk9sbva3bVG843X3JEm+pbBjR7lAfeSyipgrh5rntpSvohVIUEK
         tnhw==
X-Forwarded-Encrypted: i=1; AJvYcCWZouhteEi+vSG1yEaQ5IRek4QrWb8MEmB0Mz1g4pZCpFS0s5MSpU9RuE7DRGK5LpZ5Vuo7dPqO4w2dVuufEts=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTxbMYgFPOzlceTh+TSQrX8fr1VWgvGB0bt7WYdu4i3eUep/Jl
	HUBEfeJkAJU7Co720n+gHZ5SDmBWBpvyUVBQbsOH15/HE3ckws3tCx/YhzYrNbyEUWOYPI50F+t
	UYU7pXjKlop/90hIbv5DivBIYcQAvl/mk8zbdvrqsmx6ApQ/ghReqgdcti8XhvmHd30lQBg==
X-Gm-Gg: AZuq6aLa5ksqUrBOzTvc+eaKWQ5mN/5N+rRpICI51dbEpkqvIebfj9VzIssvc+SnwbP
	pLfJXXRCj21NU5Ji9ZIyOYM1VIcF8JJ/X6sPIHiTfcar0H8UfWzuxrQl25dxkK+Xbv7t1V0TiYw
	ulI6+tXcGkZgDsmclch0HlRSP9Ijk+MtrBZhhVjKT+DDPo7joY0GNLLakSTkFrkB4PKZbZXXA/f
	ymUVkMHA1uA9nhyPEocc6duTp+HvEy7uYFPT3/BmZFe8p3s9hZNde/Z0TIYZBP5GAn8wX4t/f4r
	ylmS2T2iuZTDRDR1sc8PBut8EHQWSPSZm8+ewfigVU79/Nyo4kAQH0N21ZEY/HVJ+czL2EKCeFN
	1
X-Received: by 2002:a05:6a00:9a8:b0:823:b5e:d0 with SMTP id d2e1a72fcca58-823aa7107a0mr14629536b3a.39.1770126325863;
        Tue, 03 Feb 2026 05:45:25 -0800 (PST)
X-Received: by 2002:a05:6a00:9a8:b0:823:b5e:d0 with SMTP id d2e1a72fcca58-823aa7107a0mr14629501b3a.39.1770126325332;
        Tue, 03 Feb 2026 05:45:25 -0800 (PST)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfc72asm24284818b3a.42.2026.02.03.05.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 05:45:24 -0800 (PST)
Date: Tue, 3 Feb 2026 21:43:03 +0800
From: Coiby Xu <coxu@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Simo Sorce <simo@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Eric Biggers <ebiggers@kernel.org>, 
	linux-integrity@vger.kernel.org, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: IMA and PQC
Message-ID: <aYH5AlnUIv9MPRiY@Rk>
References: <aXrKaTem9nnWNuGV@Rk>
 <1783975.1769190197@warthog.procyon.org.uk>
 <2265997.1769782221@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2265997.1769782221@warthog.procyon.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8430-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.ibm.com,redhat.com,huawei.com,gmail.com,oracle.com,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coxu@redhat.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 436B7DA1F1
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 02:10:21PM +0000, David Howells wrote:
>Coiby Xu <coxu@redhat.com> wrote:
>
>> Take latest fresh CentOS Stream 10 x86_64 KVM guest as example, without any
>> file system optimization, extra ~189MB disk space is needed if all files in
>> /usr signed using by ML-DSA-65 where the disk size is 50G.
>
>Is that storing raw signatures rather than PKCS#7 wrapped signatures?

Yes, it's storing raw signatures + per ~20 bytes overhead including the
4-byte key ID.

>
>David
>

-- 
Best regards,
Coiby


