Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E17A48E881
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Jan 2022 11:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237687AbiANKsL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 14 Jan 2022 05:48:11 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35270 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiANKsK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 14 Jan 2022 05:48:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7622F61ECB;
        Fri, 14 Jan 2022 10:48:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AB1C36AE5;
        Fri, 14 Jan 2022 10:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642157289;
        bh=TApa6JrayTLVCShvMuJzFjYmVGlMvgGx/wT7OwEzGls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=po7LDfN8U5dWLgfhZO/uqFoiBLi/SZUZB02/hDfocTG45yGuGfYFJ2Cd620vVZC/3
         SA+pNqakjTsKCtIXiXzI7EtPHoooOf+8KQf/2KyYslpDWsV8ZrXbD4fupwOd0T9hju
         jR6sQ0Iq90qjegK/d6STXhI3XjBtnz4GofurAeJJt59R+w6s3+YnmwDEHj4K1WlUXU
         Plw0XW2IaucPT21QyV3Owzu8PgK08O06Uo08wt7Pj9EBqvVtj2LfxPwKsV9e/Ixf0M
         sqXYXm6Z5RvLZ1x5WrvTPSpWOhYj2yBG6Y23nRCYXwIGfS24mvozoRTkdu/9KpVGR2
         THeUCwvT69cbw==
Date:   Fri, 14 Jan 2022 11:48:02 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, serge@hallyn.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v8 03/19] ima: Move policy related variables into
 ima_namespace
Message-ID: <20220114104802.sap3rwuhtkui5ytr@wittgenstein>
References: <20220104170416.1923685-1-stefanb@linux.vnet.ibm.com>
 <20220104170416.1923685-4-stefanb@linux.vnet.ibm.com>
 <150cb51f95c3fe54e94edc5b96b2e15edb3bf399.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150cb51f95c3fe54e94edc5b96b2e15edb3bf399.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 13, 2022 at 03:26:51PM -0500, Mimi Zohar wrote:
> Hi Stefan,
> 
> On Tue, 2022-01-04 at 12:04 -0500, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Move variables related to the IMA policy into the ima_namespace. This way
> > the IMA policy of an IMA namespace can be set and displayed using a
> > front-end like SecurityFS.
> > 
> > Implement ima_ns_from_file() to get the IMA namespace via the user
> > namespace of the SecurityFS superblock that a file belongs to.
> > 
> > To get the current ima_namespace use get_current_ns() when a function
> > that is related to a policy rule is called. In other cases where functions
> > are called due file attribute modifications, use init_ima_ns, since these
> > functions are related to IMA appraisal and changes to file attributes are
> > only relevant to the init_ima_ns until IMA namespaces also support IMA
> > appraisal. In ima_file_free() use init_ima_ns since in this case flags
> > related to file measurements may be affected, which is not supported in
> > IMA namespaces, yet.
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> Please split this patch into "ima: pass through ima namespace", or some
> other name,  and "ima: Move policy related variables into
> ima_namespace".  The other option is to combine the "pass through ima
> namespace" with the 2nd patch, like Christian's example.

I was just about to comment something similar on 02/19.

I would also not introduce get_current_ns(). It's simply more honest and
if &init_ima_ns is used everywhere until multiple namespaces can
actually exists.
