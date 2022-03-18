Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002FD4DE453
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Mar 2022 23:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbiCRWzL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Mar 2022 18:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiCRWzL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Mar 2022 18:55:11 -0400
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 18 Mar 2022 15:53:52 PDT
Received: from mail.namei.org (namei.org [65.99.196.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280FB2CB18C;
        Fri, 18 Mar 2022 15:53:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.namei.org (Postfix) with ESMTPS id 2EAFA54E;
        Fri, 18 Mar 2022 22:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.namei.org 2EAFA54E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=namei.org; s=2;
        t=1647642715; bh=BZqDGcl4o9Xdi1tmgY5xW03TbMhpKwFz2zY2lit+duU=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=0TadzwHr15LTwfizUFip6H4pI3PAx0t6kiX1pSKaHZtrSeiTKZ5755Fp9HWxrgvKf
         4tcy3l8Px/hTrLtlWSPlDj/76pw8p5ovHGT01GTBIurqnG0tBB5aHeOmv4fbMasoMa
         FEjy5O3FKGFA1pMOWJNUW2KQeAcL7T/rymjP59w0=
Date:   Sat, 19 Mar 2022 09:31:55 +1100 (AEDT)
From:   James Morris <jmorris@namei.org>
To:     linux-security-module@vger.kernel.org
cc:     linux-kernel@vger.kernel.org, lwn@lwn.net,
        fedora-selinux-list@redhat.com, linux-crypto@vger.kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        Audit-ML <linux-audit@redhat.com>, gentoo-hardened@gentoo.org,
        keyrings@linux-nfs.org, tpmdd-devel@lists.sourceforge.net,
        Linux Security Summit Program Committee 
        <lss-pc@lists.linuxfoundation.org>
Subject: Re: [ANNOUNCE][CFP] Linux Security Summit North America 2022
In-Reply-To: <3e5acc67-829-fafb-c82-833fc22b35a@namei.org>
Message-ID: <3f2d2915-b2b9-1646-d0e9-192296327633@namei.org>
References: <3e5acc67-829-fafb-c82-833fc22b35a@namei.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 8 Feb 2022, James Morris wrote:

>   * Event:                September 23-24

Correction: This should be 23-24 June per the top of the email.


-- 
James Morris
<jmorris@namei.org>

