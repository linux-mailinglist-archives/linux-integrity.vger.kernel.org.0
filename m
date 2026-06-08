Return-Path: <linux-integrity+bounces-9768-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BPCfJKk+JmqUTwIAu9opvQ
	(envelope-from <linux-integrity+bounces-9768-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 06:01:45 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E9C65289C
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Jun 2026 06:01:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="fM84IcI/";
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9768-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9768-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BBAF9300159F
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jun 2026 04:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3278B29405;
	Mon,  8 Jun 2026 04:01:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911F168BD;
	Mon,  8 Jun 2026 04:01:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780891300; cv=none; b=q+lSB5WvcYogi4bJ8JdQcO9uWa//RMDAf90FD9h36mcyP0aoTFNnBZnx53Wnhxs+/nVkJuqypD9WGF4ckKlQLjWuSO4naPK6I6P1eMawum2Wm2wEDrSzxuaDxXYGkzHHSZaLM2NEvx/IpWGAW6NHMXNL/ifCwN+6pACuj/QdL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780891300; c=relaxed/simple;
	bh=RaLnUnhwbfFEjvT/vf9CjJ+x30/U7OhK+WtQuIcKdwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R6lFp6fKQ0Bbr7AtPnVdMlUlASZjmCAaYkxm+o7RUQirXoZlKpbJnJZPVI4G91N64oj+ljRdEvb68nM0ko2oe4ztnnq5iBNAtJfOKiyO6kndjb1ORLcYEYm7E5AMDrWZbrTyC/FkID13WOXufHauHmrX/2MZY44vEHNd0dK3+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM84IcI/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3CCB01F00893;
	Mon,  8 Jun 2026 04:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780891298;
	bh=Lvr28qF/drqKhq4fyZYhBGe9uFTF2BdFmLtuvMB+Q4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fM84IcI/EOI4v3nKftD2Rs9cvyevsMhpsJlaEwfSs5YhZfucAm6S8o0zzfI2LVzMY
	 OkLUINhlV6KCosD9E/dBlVmrBw7SWS1oS/VS82D3GIvfLUP0zJT4xuz/13gu9xBapP
	 qJ0XbUBYQzqEGk3Mnhfo+bN7CQnLMRnXz5Xz3yFinNyrVPIZgjNkkufsehOycV06RQ
	 MWo8XtaaoII0Q1rvtjCsVlVzhMAgxZsC+VonWpJlDC99LJDaBS3BUQ2uHpSswQVBE/
	 tAndm7gf8Ggs+GUpBPg+XWnaoUdtTZypo7/FZhImkyYQwRoedQY7N5IECNAuoTQ4va
	 6/y2I0v253NcQ==
Date: Mon, 8 Jun 2026 07:01:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, paul@paul-moore.com,
	zohar@linux.ibm.com, roberto.sassu@huaweicloud.com,
	noodles@earth.li, sudeep.holla@kernel.org, jmorris@namei.org,
	serge@hallyn.com, dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com, jgg@ziepe.ca
Subject: Re: [PATCH v5 4/4] tpm: tpm_crb_ffa: revert defered_probed when
 tpm_crb_ffa is built-in
Message-ID: <aiY-nvx96uQtJOxP@kernel.org>
References: <20260601142749.3379697-1-yeoreum.yun@arm.com>
 <20260601142749.3379697-5-yeoreum.yun@arm.com>
 <ah5AD69RNBdE1BvO@kernel.org>
 <ah7TAk3iItltddzT@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah7TAk3iItltddzT@e129823.arm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9768-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:yeoreum.yun@arm.com,m:linux-security-module@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:paul@paul-moore.com,m:zohar@linux.ibm.com,m:roberto.sassu@huaweicloud.com,m:noodles@earth.li,m:sudeep.holla@kernel.org,m:jmorris@namei.org,m:serge@hallyn.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:jgg@ziepe.ca,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,paul-moore.com,linux.ibm.com,huaweicloud.com,earth.li,kernel.org,namei.org,hallyn.com,gmail.com,oracle.com,ziepe.ca];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 81E9C65289C

On Tue, Jun 02, 2026 at 01:56:34PM +0100, Yeoreum Yun wrote:
> > On Mon, Jun 01, 2026 at 03:27:49PM +0100, Yeoreum Yun wrote:
> > > commit 746d9e9f62a6 ("tpm: tpm_crb_ffa: try to probe tpm_crb_ffa when it's build_in")
> > > probe tpm_crb_ffa forcefully when it's built-in to integrate with IMA.
> > > 
> > > However, IMA now provides the IMA_INIT_LATE_SYNC build option, which
> > > initialises IMA at the late_initcall_sync level, so this change is no
> > > longer required.
> > > 
> > > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Might be rb tag?. Thanks!
> 
> -- 
> Sincerely,
> Yeoreum Yun

SOB is enough information as it is a small change. I pushed it to
for-next-tpm.

BR, Jarkko

