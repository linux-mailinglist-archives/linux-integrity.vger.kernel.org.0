Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D7649CC96
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiAZOoL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:44:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234426AbiAZOoK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:44:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DF2C06161C;
        Wed, 26 Jan 2022 06:44:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5731B8189A;
        Wed, 26 Jan 2022 14:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AB0C340E3;
        Wed, 26 Jan 2022 14:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208247;
        bh=5RHjtLdKE0I+5S464ucUclC7zt0RNgZIhmFN73NhDpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TW8NmkeFi0B2vuUREy0bXa2Mqp93LD03p0WHCoZW9cPAg/Noe7TrmJ5NoOO//Ao7l
         MVYuyaZH26SsAM47WNUC20X9h9pKuqCblr0Gmpl1FAS+AU0c6v6AazIJMyxigvZ5h4
         b56UUQhLMYpdfiWM2LCUy9w3kKjAPgsQJptD9XRpPzSMd5TsESF0WuG92b6uoWP5Gn
         0XrG/Q7DONBbXkCb/yu34c757qHae/SqX3cdWDw6ZefCPJiw36k8ZUuvPv3qlMYVKE
         LwL4lZRsyfh8fzWP6W0L9GkcT+GcKkQYpM6MCCZ4WgvEMFcOE/Xg5867CFQVnWbtOu
         lybUzQUZjvrng==
Date:   Wed, 26 Jan 2022 15:43:59 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 22/23] ima: Show owning user namespace's uid and gid
 when displaying policy
Message-ID: <20220126144359.nj5p23pajme5afep@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-23-stefanb@linux.vnet.ibm.com>
 <20220126144326.ci646xkm7mjsqwci@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220126144326.ci646xkm7mjsqwci@wittgenstein>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 26, 2022 at 03:43:26PM +0100, Christian Brauner wrote:
> On Tue, Jan 25, 2022 at 05:46:44PM -0500, Stefan Berger wrote:
> > From: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > Show the uid and gid values relative to the user namespace that is
> > currently active. The effect of this changes is that when one displays
> > the policy from the user namespace that originally set the policy,
> > the same uid and gid values are shown in the policy as those that were
> > used when the policy was set.
> 
> "Make sure that the uid and gid values associated with the relevant
> ima policy are resolved in the user namespace of the opener of the
> policy file."
> 
> is more correct. Also note, that by virtue of enforcing that securityfs
> files can only ever be opened if the opener's userns is the same or an
> ancestor of the userns the securityfs instance is mounted in we are
> guaranteed that the uid and gid can be resolved. That's another way of
> saying technically *_munged() isn't necessary but it is more correct
> since we're crossing the user-kernel boundary.
> 
> > 
> > Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> > 
> > ---

Acked-by: Christian Brauner <brauner@kernel.org>
