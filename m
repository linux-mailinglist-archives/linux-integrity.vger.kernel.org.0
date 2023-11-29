Return-Path: <linux-integrity+bounces-287-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 131A57FE1E8
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 22:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30BD282AF0
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Nov 2023 21:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666D2B9B3;
	Wed, 29 Nov 2023 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=namei.org header.i=@namei.org header.b="esqokkU6"
X-Original-To: linux-integrity@vger.kernel.org
X-Greylist: delayed 470 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 13:27:23 PST
Received: from mail.namei.org (namei.org [65.99.196.166])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0357FD7D;
	Wed, 29 Nov 2023 13:27:22 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by mail.namei.org (Postfix) with ESMTPS id AD5651E9;
	Wed, 29 Nov 2023 21:19:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org AD5651E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
	t=1701292771; bh=a4+Bn7RqABOY0GmF4sZWzB4XQIxtLMsIpqqVdVd/R/g=;
	h=Date:From:To:cc:Subject:From;
	b=esqokkU6m4nf9dlOK918bRvVgtUX1grKBeAa/6AFK1BFKHD7FLB9T9rZnn2FQju4M
	 FQMGgT6R/+KJxex7roE249lEkPpcB7d7oKrbBWUBxuegkHAwBnS5v3JvCOMceY8GGB
	 OUsmld/soqMTAIKUeFJ3nijvJUEmUYv4888HBa2I=
Date: Wed, 29 Nov 2023 13:19:31 -0800 (PST)
From: James Morris <jmorris@namei.org>
To: linux-security-module@vger.kernel.org
cc: Linux Security Summit Program Committee <lss-pc@lists.linuxfoundation.org>, 
    lwn@lwn.net, linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org, 
    kernel-hardening@lists.openwall.com, linux-integrity@vger.kernel.org, 
    Audit-ML <linux-audit@redhat.com>
Subject: [ANNOUNCE] CFP: Linux Security Summit North America 2024
Message-ID: <826fd432-1acf-16be-e7a9-d692aeed23f0@namei.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


==============================================================================
                   ANNOUNCEMENT AND CALL FOR PARTICIPATION

                   LINUX SECURITY SUMMIT NORTH AMERICA 2024
                             
                                 April 18-19
                              Seattle, WA, USA
==============================================================================

DESCRIPTION
 
Linux Security Summit North America 2024 is a technical forum for
collaboration between Linux developers, researchers, and end-users.  Its
primary aim is to foster community efforts in deeply analyzing and solving
Linux operating system security challenges, including those in the Linux
kernel.

Presentations are expected to focus deeply on new or improved technology and
how it advances the state of practice for addressing these challenges.

The program committee currently seeks proposals for:
 
   * Refereed Presentations:
     45 minutes in length.
 
   * Panel Discussion Topics:
     45 minutes in length.
 
   * Short Topics:
     30 minutes in total, including at least 10 minutes discussion.
 
   * Tutorials
     90 minutes in length.

Tutorial sessions should be focused on advanced Linux security defense
topics within areas such as the kernel, compiler, and security-related
libraries.  Priority will be given to tutorials created for this conference,
and those where the presenter is a leading subject matter expert on the
topic.
 
Topic areas include, but are not limited to:

    * Access Control
    * Case Studies
    * Cryptography and Key Management
    * Emerging Technologies, Threats & Techniques
    * Hardware Security
    * IoT and Embedded Security
    * Integrity Policy and Enforcement
    * Open Source Supply Chain for the Linux OS
    * Security Tools
    * Security UX
    * Linux OS Hardening
    * Virtualization and Containers

Proposals should be submitted via:
    https://events.linuxfoundation.org/linux-security-summit-north-america/


LSS-NA DATES
 
  * CFP close:            Jan 21, 2024
  * CFP notifications:    Feb 06, 2024
  * Schedule announced:   Feb 08, 2024
  * Event:                Apr 18-19, 2024


WHO SHOULD ATTEND
 
We're seeking a diverse range of attendees and welcome participation by
people involved in Linux security development, operations, and research.
 
LSS is a unique global event that provides the opportunity to present and
discuss your work or research with key Linux security community members and
maintainers.  It's also useful for those who wish to keep up with the latest
in Linux security development and to provide input to the development
process.


WEB SITE

    https://events.linuxfoundation.org/linux-security-summit-north-america/


MASTODON

  For event updates and announcements, follow:
    
    https://social.kernel.org/LinuxSecSummit
  
  #linuxsecuritysummit


PROGRAM COMMITTEE

  The program committee for LSS 2024 is:

    * James Morris, Microsoft
    * Serge Hallyn, Cisco
    * Paul Moore, Microsoft
    * Stephen Smalley, NSA
    * Elena Reshetova, Intel
    * John Johansen, Canonical
    * Kees Cook, Google
    * Casey Schaufler
    * Mimi Zohar, IBM
    * David A. Wheeler, Linux Foundation

  The program committee may be contacted as a group via email:
    lss-pc () lists.linuxfoundation.org


