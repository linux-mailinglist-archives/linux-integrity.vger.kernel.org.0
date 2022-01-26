Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD67649C546
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 09:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiAZIan (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 03:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiAZIam (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 03:30:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6F8C06161C;
        Wed, 26 Jan 2022 00:30:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A485CB81C13;
        Wed, 26 Jan 2022 08:30:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC646C340E3;
        Wed, 26 Jan 2022 08:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643185839;
        bh=qKazU28NFPi1JaZnJrqSAMht8qRDH0NxIN7MLjkqLqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPWQNvgAyMwwqb0Ni1Ase2Q9wL5sOBkJ+9hRMUWNP3bxm9BiQH7CnQIH2dxzcSszN
         g0z5UOqsQQDEHg50yZDClr4pXnj/GNXR4sQkqc1tREwWE+grwOvcOGo/DMfpoxEDsp
         VKpKpqBBhYB9gjcZPAaSENV7OstEIHozmvf+wLJ7/Onnl5TTPbSUZySgr2m5k79+Pu
         22xVzNSkGljlVJmdTmRbF643FrqBvft1U/9Vrt5BA6irynPpNr/lVoesnWMviLvNVe
         XNIuhb/liA9PytK1+dOMbcXmolTxksY2cnbwfrBCtyG3H2jlShcOg+beYjCWrOUJm7
         VMWP2wMUmUvVw==
Date:   Wed, 26 Jan 2022 09:30:30 +0100
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
Subject: Re: [PATCH v9 01/23] ima: Remove ima_policy file before directory
Message-ID: <20220126083030.theijkt7v3w3fwm5@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-2-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-2-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:23PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> The removal of ima_dir currently fails since ima_policy still exists, so
> remove the ima_policy file before removing the directory.
> 
> Fixes: 4af4662fa4a9 ("integrity: IMA policy")
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---

Looks good,
Acked-by: Christian Brauner <brauner@kernel.org>
