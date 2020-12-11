Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 214742D79A9
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 16:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389890AbgLKPnF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 10:43:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:47878 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389818AbgLKPmk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 10:42:40 -0500
Received: from sequoia (162-237-133-238.lightspeed.rcsntx.sbcglobal.net [162.237.133.238])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4623120B717A;
        Fri, 11 Dec 2020 07:41:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4623120B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1607701319;
        bh=Z/5G5fthLzonRDLWBgNgSdlHyzkpMnlXBp85Z/JmUyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nf5TLx3vn1lcKB1DA4lTJX2EqfcTb6cgQo7D/Gl5k2AbejMIWpYMlh/0gcUtFSJLE
         cc8/kh1eKFDzZRxST7ClYDExhCA5K51LpSo2SatfJDL0ah2nStK27gGg8RH+rJ/88P
         PyFkmr4/3vPKg1Dn+H9dwS1PT53uCJ7n4SAKGADg=
Date:   Fri, 11 Dec 2020 09:41:56 -0600
From:   Tyler Hicks <tyhicks@linux.microsoft.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     zohar@linux.ibm.com, stephen.smalley.work@gmail.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, paul@paul-moore.com, sashal@kernel.org,
        jmorris@namei.org, nramas@linux.microsoft.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v7 8/8] selinux: include a consumer of the new IMA
 critical data hook
Message-ID: <20201211154156.GB4951@sequoia>
References: <20201209194212.5131-1-tusharsu@linux.microsoft.com>
 <20201209194212.5131-9-tusharsu@linux.microsoft.com>
 <20201211153618.GA4951@sequoia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211153618.GA4951@sequoia>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2020-12-11 09:36:30, Tyler Hicks wrote:
> The calls to pr_err() in this aren't quite following the style of the
> other error SELinux error messages.

Sorry, I left out a word. I meant to say that the calls to pr_err() in
this *file* aren't quite following the right style. Please adjust all of
them.

Thanks!

Tyler
