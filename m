Return-Path: <linux-integrity+bounces-9639-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG5VGFJSEGovWQYAu9opvQ
	(envelope-from <linux-integrity+bounces-9639-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 14:55:46 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0A85B4985
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 14:55:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D19A2301226E
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820043A75A3;
	Fri, 22 May 2026 12:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cB6kaG4Q"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CAD3905E6;
	Fri, 22 May 2026 12:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453857; cv=none; b=Qlgh+m+JIQ9LQPD0i8CI7y8AjTCyswAKCgTO56cJHc1rPoBvR43JPEvpBgfSWz8VkdR6pa2fZjbL7vJ7yj4+YR8BXrfIvWr/lcDdx/FSvhENcTOhPsi6fZdSw9DIEvI3tObRACpH+G9kMIXdLjeboOZllr4fP6rkvpr5ZaOA+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453857; c=relaxed/simple;
	bh=t0JqiLNTEkZCrpYjySbXc43yBONIgwGPVeqhTsCtCUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZOtPQVeQB3OliBOwH8St47Dpaxs4EdL/gEO962lLONDBXZXBkPvWovU5oOKIZQXr1ZKkOUCv3GRQ0IgZTxOXt9TX+Wm1L+XFc+v9Xj2XKBou4IVewX/uben9DQVPtFa4SapzBHEb3zPsg+t62KQX3A3Bui+QpWIq80U81s6HdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cB6kaG4Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9618C1F000E9;
	Fri, 22 May 2026 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453849;
	bh=47vZJgT17m1gFeLeusKzcCkCXnp6I/DswSFSH/W33zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cB6kaG4QlVx2i7APXXqb0f+a6TNu/I78IUkA4c1KcASl8MRKm+YFudi/OnIcXKFLK
	 FBNm6aXcg1qXHID3x+qmEbhU1inlqyqn7j1/UNBWIuhL2iUT+ECxjJQzHjaYtYZzGN
	 hGahwXgG81FQW65EsP/XepJbzDAOePx7f2zsDKNVtXCI65I56MsIzymQEgK7JBgiGH
	 rK0MeHpl7OGthpHB8tsmQkWwysIszW0DPl5mpEjSJJprPQZM09CXK0stbzVvjlnlAT
	 6S+zF924q7u09ZEN9wX1Dg9VOlKijtXl9vP2MF39ZuS82G7J+PO1EJ1yYutF8qfzlR
	 HOvGO+adggLLg==
Date: Fri, 22 May 2026 15:44:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Use named initializers for arrays of i2c_device_data
Message-ID: <ahBPlW1l2RAdxpT6@kernel.org>
References: <20260518134035.644762-2-u.kleine-koenig@baylibre.com>
 <ag98e88678TSfwxG@kernel.org>
 <ag_vkHJjmCo_FFa5@monoceros>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ag_vkHJjmCo_FFa5@monoceros>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,microchip.com,bootlin.com,tuxon.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-9639-lists,linux-integrity=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BC0A85B4985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 10:16:39AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello Jarkko,
> 
> On Fri, May 22, 2026 at 12:43:23AM +0300, Jarkko Sakkinen wrote:
> > On Mon, May 18, 2026 at 03:40:35PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> > > The union added to struct i2c_device_id enables further cleanups like:
> > > 
> > > 	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
> > > 	index 0123ca8157a8..dfb0b07500a7 100644
> > > 	--- a/drivers/regulator/ad5398.c
> > > 	+++ b/drivers/regulator/ad5398.c
> > > 	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
> > > 	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};
> > > 
> > > 	 static const struct i2c_device_id ad5398_id[] = {
> > > 	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
> > > 	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
> > > 	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
> > > 	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
> > > 	 	{ }
> > > 	 };
> > > 	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
> > > 	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
> > > 	 	struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
> > > 	 	struct regulator_config config = { };
> > > 	 	struct ad5398_chip_info *chip;
> > > 	-	const struct ad5398_current_data_format *df =
> > > 	-	                (struct ad5398_current_data_format *)id->driver_data;
> > > 	+	const struct ad5398_current_data_format *df = id->driver_data_ptr;
> > > 
> > > 	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> > > 	 	if (!chip)
> 
> [redacted the example as it didn't compile as presented, added "_ptr" on
> last hunk's + line.]
>  
> > > that are an improvement for readability (again!) and it keeps some
> > > properties of the pointers (here: being const) without having to pay
> > > attention for that. (I didn't find a tpm driver that benefits, so this
> > > is "only" a regulator driver example.)
> > > 
> > > My additional motivation for this effort is CHERI[1]. This is a hardware
> > > extension that uses 128 bit pointers but unsigned long is still 64 bit.
> > > So with CHERI you cannot store pointers in unsigned long variables.
> > 
> > I don't understand why any of this should be merged to be honest and
> > why I should care about CHERI when reviewing mainline patches.
> 
> While I think and hope that CHERI will become relevant for the industry soon,
> it's ok to not care about CHERI today and I mostly mentioned it to be
> transparent about *my* motivation.
> 
> Our eventual goal is to bring CHERI support to mainline linux so my team
> mates and I have to find a way to get patches like that in. In my eyes
> this compares well to PREEMPT RT: With that you have to follow more
> rules in some situations and implementing these and running an RT kernel
> makes bugs pop up that also affect mainline.
> 
> So I claim that working on CHERI is obviously beneficial to folks who
> have CHERI hardware, but also helps those who don't as CHERI is a way to
> easily spot a relevant set of bugs.
> 
> > Clean up can be side-effect but not a purpose.
> 
> Oh, I disagree. Having code in a state where you can easily see what
> happens helps to concentrate on the parts that are more complicated. So
> it's a win for maintenance and lowering the entry bar for people who are
> not used to Linux kernel code. There are parts in the kernel that are
> complicated, and we won't get rid of them, because operating systems are
> complicated. But my POV here is that making it easier where it's
> possible is a good thing and a reason for itself. You might call that a
> paper cut only, but these add up.
> 
> Also with the union in i2c_device_id the compiler warns you if some code
> is lacking a "const". So it becomes harder to make mistakes, this is
> also a reason that in my book is good enough for itself.

Actually what I said is more important than ever before given AI agents.

If I start to accept pure cleanups from humans it's like invitiation for
slop. This is actually an area where it would be advicable for any
maintainer to tighten the acceptance criteria.

> 
> Best regards
> Uwe

BR, Jarkko

