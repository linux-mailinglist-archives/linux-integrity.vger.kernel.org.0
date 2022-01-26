Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B37F49CBAC
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 14:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235073AbiAZN47 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 08:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbiAZN47 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 08:56:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6CCC06161C;
        Wed, 26 Jan 2022 05:56:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9368561620;
        Wed, 26 Jan 2022 13:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EF9C340E3;
        Wed, 26 Jan 2022 13:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643205418;
        bh=ueAPcls8rcI0FPvsY3aAdiAUO3+DvUdXA+9iz3Lihdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSFJ9hsKSTd/qF7QlDDgLpOj+0VeHmAyWYSLq3tEImy9/WNUIE926g5dLMSuFiXV4
         L4qHD+pFRWXAnWpQ/qVu2F+X/nfIFDzMCF7jXfE45LPswlj+J9n7SxD4sN5qmBc/xW
         uSnk072sQ9qqE+XqAQSDVFl2s2y6KrnOReN1FyCm31l715nUSVwXzo/i9FeE2gHqrg
         QSZG9BxlNn5ireUgqbwYFwYL6BHsVFj7vSoYwtTvYmwwPaX8BdpdCe47/ycdTw7GFx
         Z4XRixS0/Pn8IBxWCPaQwT0Ln8wV/5jbMXfWNqofnWgNbqfb+ShiUMJP0Hm5QxdhXW
         zYe5rol/VThaw==
Date:   Wed, 26 Jan 2022 14:56:50 +0100
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
Subject: Re: [PATCH v9 17/23] ima: Add functions for creating and freeing of
 an ima_namespace
Message-ID: <20220126135650.anx6el6d2npopxqz@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-18-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-18-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:39PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Implement create_ima_ns() to create an empty ima_namespace. Defer its
> initialization to a later point outside this function. Implement
> free_ima_ns() to free it.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Ok,
Acked-by: Christian Brauner <brauner@kernel.org>
