Return-Path: <linux-integrity+bounces-4839-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153CBA383F0
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7631738D0
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4A21B90F;
	Mon, 17 Feb 2025 13:06:52 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72ADE215F49;
	Mon, 17 Feb 2025 13:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797612; cv=none; b=Km2BKqIHOkvdycGF7fIei6jyphauagyLNpqdX3O/yn52nxbfhFswJAAxJuzBBkFEjQbXyof9cHzJ7sAwCH6JdF52PvtCxUZcY035dBr0WUjV+1V/sMWi/9a5AKNawpZWOPvautdRcB7yhfI/FOPTxe0gRNPU94Z0ORMSBlvJCCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797612; c=relaxed/simple;
	bh=nN4o3P1mouOHENLPIOBJJsndTSO4QsgADBehLhpRlW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNmQ/wR8Y3BaMXlbC+OQn67HLpVQRtFsTaHuUUswSy+8hdb0xqMs4HMXbwtWPx8irPQMmtDpslFii7LKQTzc9njVypckkDVO0VX74Us259zueBvi0lx5NrqeOJxHrdwEbzqcXqvMeRfhDH4GIUI9/8xnzcDCiAd7scFccPO9AyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 51HCjfgB011690;
	Mon, 17 Feb 2025 06:45:41 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 51HCjcjw011689;
	Mon, 17 Feb 2025 06:45:38 -0600
Date: Mon, 17 Feb 2025 06:45:38 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: James Morris <jmorris@namei.org>
Cc: linux-security-module@vger.kernel.org,
        Linux Security Summit Program Committee <lss-pc@lists.linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org, lwn@lwn.net
Subject: Re: [Announce] Linux Security Summit North America 2025 CfP
Message-ID: <20250217124538.GA11605@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <35b17495-427f-549f-6e46-619c56545b34@namei.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35b17495-427f-549f-6e46-619c56545b34@namei.org>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Mon, 17 Feb 2025 06:45:41 -0600 (CST)

On Mon, Feb 10, 2025 at 01:03:02PM -0800, James Morris wrote:

Good morning, I hope the week is starting well for everyone.

> The Call for Participation for the 2025 Linux Security Summit North 
> America (LSS-NA) is now open.
> 
> LSS-NA 2025 is a technical forum for collaboration between Linux 
> developers, researchers, and end-users. Its primary aim is to foster 
> community efforts in deeply analyzing and solving Linux operating system 
> security challenges, including those in the Linux kernel. Presentations 
> are expected to focus deeply on new or improved technology and how it 
> advances the state of practice for addressing these challenges.
>
> Key dates:
> 
>     - CFP Closes:  Monday, March 10 at 11:59 PM MDT / 10:59 PM PDT
>     - CFP Notifications: Monday, March 31
>     - Schedule Announcement: Wednesday, April 2
>     - Presentation Slide Due Date: Tuesday, June 24
>     - Event Dates: Thursday, June 26 ??? Friday, June 27
> 
> Location: Denver, Colorado, USA (co-located with OSS).

I reflected a great deal before responding to this note and finally
elected to do so.  Given the stated desire of this conference to
'focus deeply on new or improved technologies' for advancing the state
of practice in addressing the security challenges facing Linux, and
presumably by extension, the technology industry at large.

I'm not not sure what defines membership in the Linux 'security
community'.  I first presented at the Linux Security Summit in 2015,
James you were moderating the event and sitting in the first row.

If there is a desire by the Linux Foundation to actually promote
security innovation, it would seem the most productive use of
everyone's time would be to have a discussion at this event focusing
on how this can best be accomplished in the context of the current
Linux development environment.

If we have done nothing else with our Quixote/TSEM initiative, I
believe we have demonstrated that Linux security development operates
under the 'omniscient maintainer' model, a concept that is the subject
of significant discussion in other venues of the Linux community:

https://lore.kernel.org/lkml/CAEg-Je9BiTsTmaadVz7S0=Mj3PgKZSu4EnFixf+65bcbuu7+WA@mail.gmail.com/

I'm not here to debate whether that is a good or bad model.  I do
believe, that by definition, it constrains the innovation that can
successfully emerge to something that an 'omniscient' maintainer
understands, feels comfortable with or is not offended by.

It should be lost on no one that the history of the technology
industry has largely been one of disruptive innovation that is
completely missed by technology incumbents.

The future may be the BPF/LSM, although no one has yet publically
demonstrated the ability to implement something on the order of
SeLinux, TOMOYO or Apparmor through that mechanism.  It brings as an
advantage the ability to innovate without constraints as to would be
considered 'acceptable' security.

Unfortunately, a careful review of the LSM mailing list would suggest
that the BPF/LSM, as a solution, is not politically popular in some
quarters of the Linux security community.  There have been public
statements that there isn't much concern if BPF breaks, as the concept
of having external security policy is not something that should be
supported.

We took an alternative approach with TSEM, but after two years of
submissions, no code was ever reviewed.  I'm not here to bitch about
that, however, the simple fact is that two years with no progress is
an eternity in the technology industry, particularly security, and
will serve to drive security innovation out of the kernel.

One can make a reasoned and informed argument that has already
happened.  One of the questions worthy of debate at a conference with
the objectives stated above.

I apologize if these reflections are less than popular but they are
intended to stimulate productive discussion, if the actual intent of
the conference organizers is to focus deeply on new and improved
security technology.

There is far more technology potentially available than there are good
answers to the questions as to how to effectively exploit it.

> James Morris
> <jmorris@namei.org>

Best wishes for a productive week.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project

