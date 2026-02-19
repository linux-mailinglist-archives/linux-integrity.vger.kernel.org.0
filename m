Return-Path: <linux-integrity+bounces-8521-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDAPOscol2mXvQIAu9opvQ
	(envelope-from <linux-integrity+bounces-8521-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 16:14:15 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24F15FFF4
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 16:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FCEF309211C
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Feb 2026 15:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E109342C88;
	Thu, 19 Feb 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="gnk1NPQp";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="fuWYs2EN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BBE3431E7;
	Thu, 19 Feb 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771513552; cv=none; b=avLU3kc/iT8ZX1P9LbzqpY3jpiuZu/VhVKPgOs9GY4XmDapWyujI/u+trWRgHct0ROyGiNg7LNMJbvA5YvnvxvJPX2Lh982hhdrL2glbURvnQpHQO2zYXQFuIesiYCbKhHiPUDDgoFxGtIdMDB5TyBMLzok2Ggu/fDzCprYSMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771513552; c=relaxed/simple;
	bh=kY+CNc6etMGmouRQiTTjRGVawYjSYZ7ooeSd481nsXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X2lx7n8Z1+FPH+eZBDWIis7xHw7XCkicfECfIyajbj8wViME87dnh9wU622PRxHT0W/Z4PAjm3cpVFOkCSOWMW+VNxa1C1EF7uoM9iMIwBNmXuiyCk5TQW1DGJr+kPegYUcEO3rhgOOOEZatB7khUu2QE68rwc0VaP45bgrhIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=gnk1NPQp; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=fuWYs2EN; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1771513304; bh=o7hLZZotTPOFzfWMuGMKqGC
	Zc/cpqQOZc6BNxHF+9Sg=; b=gnk1NPQpzGN9oV/kfbSfsrhcMS/Q27v2h7aSt66f5ERJ8IZXkr
	w8Ku7C/HnZzmPeEHr47vIfqAtgGktFqGiqxBXm0wZUWInQElShfEi3fI6fyg6o1MDYdZskVB+8L
	BxyrMhlEOPzUDXFRF1iqJxoin57LMENtxD3lt8rjX7EiMRBi9YhhVvRBkoliFeSdIKF+8PMF5Wt
	n9QbGPsTx7AC0+YiIeQfZbp7axBFa4zptiisqsPtLOfxXMq7JEVDZU+aPGXzYsbLh0KLeWe1r2v
	ELpWY0RMuR7JYwmYbqy6ZG0a9GucEew2kU9ZPMgSD14Z/VmI2JSkx+8QMqE5Wiw6PCQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Subject:To:From:Date; t=1771513304; bh=o7hLZZotTPOFzfWMuGMKqGC
	Zc/cpqQOZc6BNxHF+9Sg=; b=fuWYs2ENdcwZTH9/cP+205XS8Nk7Zwx/MTirYIPEAAUquK1oKJ
	JQULRPOpGgU/HNLHBlhEMdVONVhr+rWKruDQ==;
Date: Thu, 19 Feb 2026 10:01:43 -0500
From: Daniel Hodges <daniel@danielhodges.dev>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Daniel Hodges <git@danielhodges.dev>, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 v2] evm: check return values of crypto_shash functions
Message-ID: <lj2loy57pavtihqeuywpc2aev7zy3k3poop346dtmelmocp75q@lbejeufrrxwr>
References: <aYNprpzxppKE0Gf2@fb.com>
 <20260206024240.19059-1-git@danielhodges.dev>
 <6ce273a26b396232f3ee64a980575562e766c501.camel@huaweicloud.com>
 <cfbd9e3c63e03500279198ec7a80ba009dfccc63.camel@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfbd9e3c63e03500279198ec7a80ba009dfccc63.camel@huaweicloud.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8521-lists,linux-integrity=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@danielhodges.dev,linux-integrity@vger.kernel.org];
	FREEMAIL_CC(0.00)[danielhodges.dev,linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-integrity];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[danielhodges.dev:email,danielhodges.dev:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A24F15FFF4
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 01:36:39PM +0100, Roberto Sassu wrote:
> On Thu, 2026-02-19 at 10:26 +0100, Roberto Sassu wrote:
> > On Thu, 2026-02-05 at 21:42 -0500, Daniel Hodges wrote:
> > > The crypto_shash_update() and crypto_shash_final() functions can fail
> > > and return error codes, but their return values were not being checked
> > > in several places in security/integrity/evm/evm_crypto.c:
> > > 
> > > - hmac_add_misc() ignored returns from crypto_shash_update() and
> > >   crypto_shash_final()
> > > - evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
> > > - evm_init_hmac() ignored returns from crypto_shash_update()
> > > 
> > > If these hash operations fail silently, the resulting HMAC could be
> > > invalid or incomplete, which could weaken the integrity verification
> > > security that EVM provides.
> > > 
> > > This patch converts hmac_add_misc() from void to int return type and
> > > adds proper error checking and propagation for all crypto_shash_*
> > > function calls. All callers are updated to handle the new return values.
> > > Additionally, error messages are logged when cryptographic operations
> > > fail to provide visibility into the failure rather than silently
> > > returning error codes.
> > > 
> > > Fixes: 66dbc325afce ("evm: re-release")
> > > Signed-off-by: Daniel Hodges <git@danielhodges.dev>
> > 
> > After fixing the minor issue below:
> 
> Already did it. The patch is here (after fixing a conflict with
> 0496fc9cdc38 "evm: Use ordered xattrs list to calculate HMAC in
> evm_init_hmac()"):
> 
> https://github.com/robertosassu/linux/commit/d5aba42198b602c6de002ef02a4e6cc1d75652d7
> 
> Roberto

Nice, thanks for handling that!

-Daniel

