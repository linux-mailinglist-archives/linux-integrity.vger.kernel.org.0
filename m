Return-Path: <linux-integrity+bounces-9111-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ENX/JHquyWnC1AUAu9opvQ
	(envelope-from <linux-integrity+bounces-9111-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 00:58:02 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA8F354628
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Mar 2026 00:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142C1300AB34
	for <lists+linux-integrity@lfdr.de>; Sun, 29 Mar 2026 22:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2864436E482;
	Sun, 29 Mar 2026 22:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b="Fbh9/3k5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27C630F92E
	for <linux-integrity@vger.kernel.org>; Sun, 29 Mar 2026 22:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774825078; cv=none; b=SBDsLzW6toUXEtI5lCq/3eY1ptX+MbPQck39pc+ZulW7zIO+Il13Rui6EU+DkHUjn8j+tTVtPW/PX0xQB8+7ecvOx/blbRd6NaVTg4qwgx1L9gnFWOcnYUb8r0itOYToNxSByCj/vai5i8rkuXbY8V4wyE8uny6M9sdQ54HQlB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774825078; c=relaxed/simple;
	bh=DkXLUmcpu+vp7QMomsKqeu+nj8dpLA67HJln8CiZhFw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTUPSYXjDxTE+iYT7E7TuivyqGKL1KCBE4x5DP460wRima+a9UiLwfV/fVmWnflBZCGss35KJ9TUh0V5Es6dHbEbaU6ZVGhTqAzeFjAo9SoMmYRqjXml68MdTlyIq1HEiavMMui8CotNDahJ9aeL/71c5hWYxzRqBDxl/wvtORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=code406.com; spf=pass smtp.mailfrom=code406.com; dkim=pass (1024-bit key) header.d=code406.com header.i=@code406.com header.b=Fbh9/3k5; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=code406.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=code406.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12732e6a123so1807227c88.1
        for <linux-integrity@vger.kernel.org>; Sun, 29 Mar 2026 15:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=code406.com; s=google; t=1774825076; x=1775429876; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EmjkZkbbVjjgaCUxuu5+nE0xjPd5gN1qT4GlMrecGi4=;
        b=Fbh9/3k5YE4y04oqhexqsWQeQ2Y6SKUKF3WuZwp0/6sj4phYuWiRBU/C08fCMQ2EHr
         BTyUJU8glTj+XLWy4pSTzGR2CL+smGXsOx1wY2z0jpGncGQmq+hfW8XyZbnfVMVXViUl
         GswqzKhrEh+7vquNe+fGCoklacbwOR0ccnIpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774825076; x=1775429876;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmjkZkbbVjjgaCUxuu5+nE0xjPd5gN1qT4GlMrecGi4=;
        b=B1b1qzOGrwFChjJYoNScTijuiIkUirRbE/eXFIvkYoW4gdZ3Vl62HNmf+G9jBikjXz
         aFhl9LmqDZDT4J+eV/3a4nfglCZIn2NEHueRbEPxyGmHZ/4RN2r9aXpkwTyeA116GMVS
         RzfJK3Wm/LsWpQvaszcWVVtFHaJiXmKdxe7oKOEpFPzjKw982rm4+tJz5Hs8MLWMX1Sn
         PJ/Hr6kRtx/cUitExzUFRFuhcxWLohtRYHrkGLgMg7rxK8klb67C0sXaT09d4qsgU+Fb
         zIuksx/l1hE96DhsH7UsP8YMoQttwOUNTsZE1RcumjCdQIkgK+mcJg4l+hu7NODADNyJ
         CZBg==
X-Forwarded-Encrypted: i=1; AJvYcCWJOD49YXd3WOToWimDxf67ivcxZ2ucGnkec5vSN/KO94iJ2DLQDc4t6T4mPCtMiyGKR3lKPoaUx6+ECiaNrC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+FM+/lgUP0Vgh/otj//coYBzN3qU0OyW04bo1qulHN7rQw+Ll
	PSIM5sj20Im+mP5c7NrgQfDs6Ms4KANbGr8qFkHd6i+bmI5/E57ghxxUKqrUumrDmw==
X-Gm-Gg: ATEYQzy6CASDA4uZENv8WYgOyKRmDXYR6Lyhj24k5ZhhPuAgAZ8RDB3P0I6bEWHhM43
	LK8tdxnxy/qZEoyjdam5sSkKlnaJ0LUwwAo2yH81Rp+ivrqriCNieGlgGQc9i6j4z+fy4lIOnHp
	hpvBmwaqPTo02RuJd27q1nCj6aB2VxbmhapcgOc5zxCciPWZhv1v5+ZMqG3lxzlQ0ycWwfhSi/K
	G0IIB6n05s7ddipqiaxEPuOZsa5P/AQlicmkhskYNAiXj9CtmLv5N6m5LplF4GDtxJj1kmT94Aa
	3Wn37sNsI1IVDSq5xUQaUDcO9cfysqWJtL82TEuvzorq416BqcfovJQlfhkkcQx8/NTCjpz+Clk
	Rvo5iWfa5cvAULF4eBiDTiLf9SNgEDJcZIzWDop6oJVFm4VO42LV6bjcvP2K2h6/wwtXEPEcylg
	x6D5i3fyLpFA2w4kC/3IwQ82macstWQLz98ufDC4RJKRH0mh7Ho715TgHB4Er74xCg01X4Kg/jK
	BdsUD2cyT6AWtCrE5zU8XT35z/t
X-Received: by 2002:a05:7022:2209:b0:11d:f89d:85a0 with SMTP id a92af1059eb24-12ab2912740mr5861569c88.27.1774825075962;
        Sun, 29 Mar 2026 15:57:55 -0700 (PDT)
Received: from ubuntu ([2601:645:8a00:6e44:958e:90e9:e30b:7ecc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab970da7fsm6096026c88.0.2026.03.29.15.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 15:57:55 -0700 (PDT)
From: Josh Snyder <josh@code406.com>
X-Google-Original-From: Josh Snyder <josh@cod406.com>
Date: Sun, 29 Mar 2026 15:57:51 -0700
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	hpa@zytor.com, dave.hansen@linux.intel.com, ardb@kernel.org, 
	mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com, 
	dwmw2@infradead.org, baolu.lu@linux.intel.com, kanth.ghatraju@oracle.com, 
	andrew.cooper3@citrix.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v15 08/28] tpm/tpm_tis: Close all localities
Message-ID: <v2l4v5imh2lmsayevxz3palyjeglpxo3qu475gjpchitgfzil2@l24ax4vevjp7>
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <20251215233316.1076248-9-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251215233316.1076248-9-ross.philipson@oracle.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[code406.com,none];
	R_DKIM_ALLOW(-0.20)[code406.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9111-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,lists.infradead.org,lists.linux.dev,apertussolutions.com,linutronix.de,redhat.com,alien8.de,zytor.com,linux.intel.com,srcf.ucam.org,hansenpartnership.com,gmx.de,ziepe.ca,amacapital.net,alum.mit.edu,gondor.apana.org.au,davemloft.net,lwn.net,xmission.com,infradead.org,oracle.com,citrix.com,googlegroups.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	DKIM_TRACE(0.00)[code406.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josh@code406.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apertussolutions.com:email,code406.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFA8F354628
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Dec 15, 2025 at 03:32:56PM -0800, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
> +		if (check_locality(chip, i))
> +			tpm_tis_relinquish_locality(chip, i);

When I applied this patch locally, tpm_chip's locality_count underflowed to -1
and no IO was performed. That is because tpm_tis_relinquish_locality is
implemented like so:

  struct tpm_tis_data *priv = dev_get_drvdata(&chip->dev);

  mutex_lock(&priv->locality_count_mutex);
  priv->locality_count--;
  if (priv->locality_count == 0)
	  __tpm_tis_relinquish_locality(priv, l);

I was able to work around the issue by calling __tpm_tis_relinquish_locality
instead.

Thanks,
Josh

