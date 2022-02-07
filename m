Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3EE4ACC2C
	for <lists+linux-integrity@lfdr.de>; Mon,  7 Feb 2022 23:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244787AbiBGWnf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 7 Feb 2022 17:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbiBGWne (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 7 Feb 2022 17:43:34 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 14:43:32 PST
Received: from mail.namei.org (namei.org [65.99.196.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17ABC061355;
        Mon,  7 Feb 2022 14:43:32 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 7235C424;
        Mon,  7 Feb 2022 22:24:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 7235C424
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1644272689; bh=0BY/V/NIgDIevFQdF+wBys4ty26sYhLszDEPcdK7lds=;
        h=Date:From:To:cc:Subject:From;
        b=1XdVNc4ggTblHTpzOBwW/SI45jMQCePu37bX4zNovZerTp2MOne46L47WP/LiNVcQ
         421qWS3h/u+x/sEhDPYdUVx6j1/HOySQeMLRET18Vh6cPbgvFQVHx9SLn8H3N4ca4H
         X2un323LTy/67B8EZaOPlHzv6fGuyaWcO3Gq0NjY=
Date:   Tue, 8 Feb 2022 09:24:49 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     linux-security-module@vger.kernel.org
cc:     linux-kernel@vger.kernel.org, lwn@lwn.net,
        fedora-selinux-list@redhat.com, linux-crypto@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Audit-ML <linux-audit@redhat.com>, gentoo-hardened@gentoo.org,
        keyrings@linux-nfs.org, tpmdd-devel@lists.sourceforge.net,
        Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>
Subject: [ANNOUNCE][CFP] Linux Security Summit North America 2022
Message-ID: <3e5acc67-829-fafb-c82-833fc22b35a@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

==============================================================================
                   ANNOUNCEMENT AND CALL FOR PARTICIPATION

                   LINUX SECURITY SUMMIT NORTH AMERICA 2022
                             
                                 23-24 June
                           Austin, Texas & Virtual
==============================================================================

DESCRIPTION
 
Linux Security Summit North America (LSS-NA) is a technical forum for
collaboration between Linux developers, researchers, and end-users.  Its
primary aim is to foster community efforts in analyzing and solving Linux
security challenges.

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
and those where the presenter a leading subject matter expert on the topic.
 
Topic areas include, but are not limited to:
 
   * Kernel self-protection
   * Access control
   * Cryptography and key management
   * Integrity policy and enforcement
   * Hardware Security
   * IoT and embedded security
   * Virtualization and containers
   * System-specific system hardening
   * Case studies
   * Security tools
   * Security UX
   * Emerging technologies, threats & techniques

  Proposals should be submitted via:
    https://events.linuxfoundation.org/linux-security-summit-north-america/


Note that for 2022, we are returning to having both North American and
European events (LSS-EU will be held in September).
 

LSS-NA DATES
 
  * CFP close:            March 30
  * CFP notifications:    April 15
  * Schedule announced:   April 19
  * Event:                September 23-24

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

TWITTER

  For event updates and announcements, follow:

    https://twitter.com/LinuxSecSummit
  
    #linuxsecuritysummit

PROGRAM COMMITTEE

  The program committee for LSS 2021 is:

    * James Morris, Microsoft
    * Serge Hallyn, Cisco
    * Paul Moore, Microsoft
    * Stephen Smalley, NSA
    * Elena Reshetova, Intel
    * John Johansen, Canonical
    * Kees Cook, Google
    * Casey Schaufler, Intel
    * Mimi Zohar, IBM
    * David A. Wheeler, Linux Foundation

  The program committee may be contacted as a group via email:
    lss-pc () lists.linuxfoundation.org

-- 


