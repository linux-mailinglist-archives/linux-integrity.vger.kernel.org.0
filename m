Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A6149CB26
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jan 2022 14:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiAZNoe (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 26 Jan 2022 08:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbiAZNod (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 26 Jan 2022 08:44:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36DBC06161C;
        Wed, 26 Jan 2022 05:44:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 507AA61544;
        Wed, 26 Jan 2022 13:44:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 185E0C340E6;
        Wed, 26 Jan 2022 13:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643204672;
        bh=zfxP5+Wosvez8opZyNTaEiUKhegHQ6reguD7EetlXsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uu+SFkucYV/iwHYtDtNfWoOajq7YhwcehNTr+qrrjbzk8TnuF0MxZdSg8JJtUIscJ
         8OH8LtMnYbYBL2e+7PGe8m3b6Z5RKuDeKZiZS4PPx5MeoORoKgyW9PoM9LpbbRmqwY
         MxYcLDnrQSEku1OaOTTIkfSawmkRzR7XjdJG8T/ZYjURiZCHL2q6kgeqj+itUjKXCW
         ACaxZ2urc0BkqyTLa31j5KwRjUs10FiaiQ5fy5A6XaNDzYoroI4wg5RXbFYGgUCLhV
         N1zWXeLXI51iF94gw5qBV50xs6lZ/v82GL9Z/F3qe38cMvuiDS4E3D/JCPk6AY+QfV
         IOSrQOKM3oiEw==
Date:   Wed, 26 Jan 2022 14:44:25 +0100
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
Subject: Re: [PATCH v9 13/23] ima: Only accept AUDIT rules for
 non-init_ima_ns namespaces for now
Message-ID: <20220126134425.4p7vwqt6myodgzhu@wittgenstein>
References: <20220125224645.79319-1-stefanb@linux.vnet.ibm.com>
 <20220125224645.79319-14-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220125224645.79319-14-stefanb@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jan 25, 2022 at 05:46:35PM -0500, Stefan Berger wrote:
> From: Stefan Berger <stefanb@linux.ibm.com>
> 
> Only accept AUDIT rules for non-init_ima_ns namespaces rejecting all rules
> that require support for measuring, appraisal, and hashing.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> 
> ---

Okay, seems sensible,
Acked-by: Christian Brauner <brauner@kernel.org>
