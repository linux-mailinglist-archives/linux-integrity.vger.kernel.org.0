Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF0A6762A7
	for <lists+linux-integrity@lfdr.de>; Sat, 21 Jan 2023 02:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbjAUBSC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Jan 2023 20:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjAUBSB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Jan 2023 20:18:01 -0500
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Jan 2023 17:17:58 PST
Received: from mail.namei.org (namei.org [65.99.196.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E6521CC;
        Fri, 20 Jan 2023 17:17:58 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id E3C12AD;
        Fri, 20 Jan 2023 22:24:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org E3C12AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1674253497; bh=832X1wFeFvBP7zn6qg1MnTozywg+pZKIevCV58PkLuU=;
        h=Date:From:To:cc:Subject:From;
        b=2OvRPlLlu0IRwFkzk7r/g4QoHBpbqWNvQvLLAd2FjSSRQ6uTnF7VFpFfWdQljqLZ9
         K0mp8sBsE3y6tP/GGTGqEJRSeyPNGKBVyggPNZ1agSJKeQ528q5mouUmCxAgh9G8bm
         V0OqQUV/M4DT+zX+z0EyR7SGjqKsLz/n3bAbAhHk=
Date:   Sat, 21 Jan 2023 09:24:57 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     linux-security-module@vger.kernel.org
cc:     Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>, lwn@lwn.net,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Audit-ML <linux-audit@redhat.com>, gentoo-hardened@gentoo.org,
        keyrings@linux-nfs.org, tpmdd-devel@lists.sourceforge.net
Subject: [ANNOUNCE] Linux Security Summit North Americ (LSS-NA) CfP
Message-ID: <3a8f10eb-df2-cfad-1d-5aeab14568e@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The Call for Participation for the 2023 LSS-NA conference is open!

See details of the event and information on submitting proposals here:
https://events.linuxfoundation.org/linux-security-summit-north-america/

LSS-NA 2023 will be in Vancouver, BC, Canada, from May 10th to May 12th. 
This will be a three day event, co-located with Open Source Summit North 
America [1].

The LSS-NA CfP is open until March 1st, 2023.


Note that announcements relating to the Linux Security Summit may be found 
now on the Fediverse, via: https://social.kernel.org/LinuxSecSummit


-- 
James Morris
<jmorris@namei.org>


[1] https://events.linuxfoundation.org/open-source-summit-north-america/
