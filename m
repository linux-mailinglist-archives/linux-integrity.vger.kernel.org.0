Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B435149C6B1
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 10:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiAZJlo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 04:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239427AbiAZJlb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 04:41:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD841C061757;
        Wed, 26 Jan 2022 01:40:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C6FB61298;
        Wed, 26 Jan 2022 09:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F4C340E3;
        Wed, 26 Jan 2022 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643190049;
        bh=4RofhmTZ+8k/nyDn6l0Cd7Ymlr906kzNpitjPOoG3RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNO4oT/J+dboOWZ78qUwkpLivm11cGo/G/+reuEfj8EkGrSqFwh5fbSFccUP7x5dr
         a2MKOiHw4LAkXHijsK0IWNPRgGQv+OirukyIqJX85OCHmaVAiTP9vN3U0plquDpObb
         HFUqXfgpZuI8k/cjrv8U3ohGEG5hWFXLxum6UCVXDKzBbSCT7hOadq3CJXpDMfSCl0
         AKuvfZBivwci7aPtDNVlrgvtFLjxAWxZ0XCfwSmHfw8ysHn102vvEgF50pc6heViv5
         hKi7lm2natgIpvYZlGqAyzQlsIonZbCzVRNAF72XOW3O8QNd/pnJQUNN7wGus7I5LJ
         n0a32KUFA90LQ==
Date:   Wed, 26 Jan 2022 10:40:42 +0100
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
Subject: Re: [PATCH v9 10/23] ima: Move IMA securityfs files into
 ima_namespace or onto stack
Message-ID: <20220126094042.l6jqu5swwsyhlt7v@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-11-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-11-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:32PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Only the securityfs IMA policy file is ever removed based on Kconfig
> options. For this reason, move the IMA securityfs policy file variable
> 'ima_policy' into the ima_namespace.
> 
> Move the other IMA securityfs files onto the stack since they are not
> needed outside the function where they are created in. Also, their cleanup
> is automatically handled by the filesystem upon umount of a virtualized
> securityfs instance, so they don't need to be explicitly freed.

I'd reverse the explantion in the commit and mention the securityfs
change that makes this move possible which is patch 3 in this version of
the series ("securityfs: rework dentry creation"); something like:

	Earlier we simplified how dentry creation and deletion is manged in
	securityfs. This allows us to move IMA securityfs files from global
	variables directly into ima_fs_ns_init() itself. We can now rely on
	those dentries to be cleaned up when the securityfs instance is cleaned
	when the last reference to it is dropped.
	
	Things are slightly different for the initial ima namespace. In contrast
	to non-initial ima namespaces it has pinning logic binding the lifetime
	of the securityfs superblock to created dentries. We need to keep this
	behavior to not regress userspace. Since ima never removes most of the
	securityfs files the initial securityfs instance stays pinned. This also
	means even for the initial ima namespace we don't need to keep
	references to these dentries anywhere.
	
	The ima_policy file is the exception since ima can end up removing it if
	a non-default policy is written at some point.

Last sentence should be checked for sensibility by ima folks.

> 
> In the failure cleanup path clean up the ima_policy dentry before
> cleaning up the directories.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---

Moving into imans looks good,
Acked-by: Christian Brauner <brauner@kernel.org>
