Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE3146041A
	for <lists+linux-integrity@lfdr.de>; Sun, 28 Nov 2021 05:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347140AbhK1E5o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 27 Nov 2021 23:57:44 -0500
Received: from mail.hallyn.com ([178.63.66.53]:42220 "EHLO mail.hallyn.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350634AbhK1Ezo (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 27 Nov 2021 23:55:44 -0500
X-Greylist: delayed 388 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Nov 2021 23:55:44 EST
Received: by mail.hallyn.com (Postfix, from userid 1001)
        id 759EBA17; Sat, 27 Nov 2021 22:45:58 -0600 (CST)
Date:   Sat, 27 Nov 2021 22:45:58 -0600
From:   "Serge E. Hallyn" <serge@hallyn.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org, containers@lists.linux.dev,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        krzysztof.struczynski@huawei.com,
        Roberto Sassu <roberto.sassu@huawei.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Michael Peters <mpeters@redhat.com>,
        Luke Hinds <lhinds@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Christian Brauner <christian@brauner.io>
Subject: Re: [RFC 1/3] userns: add uuid field
Message-ID: <20211128044558.GA11794@mail.hallyn.com>
References: <20211127164549.2571457-1-James.Bottomley@HansenPartnership.com>
 <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211127164549.2571457-2-James.Bottomley@HansenPartnership.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat, Nov 27, 2021 at 04:45:47PM +0000, James Bottomley wrote:
> As a precursor to namespacing IMA a way of uniquely identifying the
> namespace to appear in the IMA log is needed.  This log may be
> transported away from the running system and may be analyzed even
> after the system has been rebooted.  Thus we need a way of identifying
> namespaces in the log which is unique.  UUID, being designed
> probabilistically never to repeat, fits this bill so add it to the
> user_namespace which we'll also use for namespacing IMA.

If the logs run across 5 boots, is it important to you that the
uuid be unique across all 5 boots?  Would it suffice to have a
per-boot unique count and report that plus some indicator of the
current boot (like boot time in jiffies)?
