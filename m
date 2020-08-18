Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1835248BFD
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Aug 2020 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbgHRQts (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 18 Aug 2020 12:49:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51213 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgHRQts (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 18 Aug 2020 12:49:48 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1k84nw-0000Iz-OU; Tue, 18 Aug 2020 16:49:44 +0000
Date:   Tue, 18 Aug 2020 18:49:43 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     krzysztof.struczynski@huawei.com
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        linux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        stefanb@linux.vnet.ibm.com, sunyuqiong1988@gmail.com,
        mkayaalp@cs.binghamton.edu, dmitry.kasatkin@gmail.com,
        serge@hallyn.com, jmorris@namei.org, christian@brauner.io,
        silviu.vlasceanu@huawei.com, roberto.sassu@huawei.com,
        ebiederm@xmission.com, viro@zeniv.linux.org.uk,
        torvalds@linux-foundation.org, luto@amacapital.net,
        jannh@google.com
Subject: Re: [RFC PATCH 00/30] ima: Introduce IMA namespace
Message-ID: <20200818164943.va3um7toztazcfud@wittgenstein>
References: <N>
 <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200818152037.11869-1-krzysztof.struczynski@huawei.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Aug 18, 2020 at 05:20:07PM +0200, krzysztof.struczynski@huawei.com wrote:
> From: Krzysztof Struczynski <krzysztof.struczynski@huawei.com>
> 
> IMA has not been designed to work with containers. It handles every
> process in the same way, and it cannot distinguish if a process belongs to
> a container or not.
> 
> Containers use namespaces to make it appear to the processes in the
> containers that they have their own isolated instance of the global
> resource. For IMA as well, it is desirable to let processes in the

IMA is brought up on a regular basis with "we want to have this" for
years and then non-one seems to really care enough.

I'm highly skeptical of the value of ~2500 lines of code even if it
includes a bunch of namespace boilerplate. It's yet another namespace,
and yet another security framework.
Why does IMA need to be a separate namespace? Keyrings are tied to user
namespaces why can't IMA be? I believe Eric has even pointed that out
before.

Eric, thoughts?

Christian
