Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B8549CCA2
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 15:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242321AbiAZOqm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 09:46:42 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55840 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbiAZOqm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 09:46:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B937E617BB;
        Wed, 26 Jan 2022 14:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2BCC340E3;
        Wed, 26 Jan 2022 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643208401;
        bh=cJiDTU9gQID9GLUd0bo9OOnXsiH1fDIWRGx2iU5CFGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=amwz4PKzyPjQVWuKQ7wqGmy3Tn84xJxWrb+FSTfzCtPtf2hwttJFmtQEOVkBB4+yi
         CWyqvr4jYwUmdPTx7tws8wL08moCNcDvCuz6TLYAbfe1X07PdT15331mK+SqJz9V5J
         KeD7OtnMfM7MxTg66OZXdm6Jee7vb8s4Ct4vhzpYU3A3nxYs5s3j38H0UA0reF6tZv
         0k7rMiNLlzKB6fMqx02FEcb7X5DvWRyWAYUalBxOsrMoE/XATKkGra52T4FFRCNrqb
         iHKKbqU5PchFr+OBU4ezTkf1gjBIG/rdHapHl2Xx8p7YdT8dF5mb3AlLDH3EM6qBIq
         WGlQYl3oQ0qyg==
Date:   Wed, 26 Jan 2022 15:46:28 +0100
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
Subject: Re: [PATCH v9 14/23] userns: Add pointer to ima_namespace to
 user_namespace
Message-ID: <20220126144628.mxmpdcxwrxh2pfzj@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-15-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-15-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:36PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Add a pointer to ima_namespace to the user_namespace and initialize
> the init_user_ns with a pointer to init_ima_ns.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---

Looks good,
Acked-by: Christian Brauner <brauner@kernel.org>
