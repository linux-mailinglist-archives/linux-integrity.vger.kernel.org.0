Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA76A44BEF
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 21:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfFMTP4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 15:15:56 -0400
Received: from namei.org ([65.99.196.166]:38994 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbfFMTP4 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jun 2019 15:15:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by namei.org (8.14.4/8.14.4) with ESMTP id x5DJFiQn022778;
        Thu, 13 Jun 2019 19:15:44 GMT
Date:   Fri, 14 Jun 2019 05:15:44 +1000 (AEST)
From:   James Morris <jmorris@namei.org>
To:     Prakhar Srivastava <prsriva02@gmail.com>
cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, vgoyal@redhat.com
Subject: Re: [PATCH V8 2/3] Define a new ima template field buf
In-Reply-To: <20190612221549.28399-3-prsriva02@gmail.com>
Message-ID: <alpine.LRH.2.21.1906140515320.14107@namei.org>
References: <20190612221549.28399-1-prsriva02@gmail.com> <20190612221549.28399-3-prsriva02@gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 12 Jun 2019, Prakhar Srivastava wrote:

> A buffer(kexec cmdline args) measured into ima cannot be
> appraised without already being aware of the buffer contents.
> Since hashes are non-reversible, raw buffer is needed for
> validation or regenerating hash for appraisal/attestation.
> 
> This patch adds support to ima to allow store/read the
> buffer contents in HEX.
> 
> - Add two new fields to ima_event_data to hold the buf and
> buf_len [Suggested by Roberto]
> - Add a new temaplte field 'buf' to be used to store/read
> the buffer data.[Suggested by Mimi]
> - Updated process_buffer_meaurement to add the buffer to
> ima_event_data. process_buffer_measurement added in
> "Define a new IMA hook to measure the boot command line
>  arguments"
> - Add a new template policy name ima-buf to represent
> 'd-ng|n-ng|buf'
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>


Reviewed-by: James Morris <jamorris@linux.microsoft.com>


-- 
James Morris
<jmorris@namei.org>

