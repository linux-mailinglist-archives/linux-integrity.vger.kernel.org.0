Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D4A3CB1F0
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 07:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbhGPFhv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 01:37:51 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43144 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbhGPFhv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 01:37:51 -0400
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 6AF2220B6C14;
        Thu, 15 Jul 2021 22:34:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6AF2220B6C14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1626413696;
        bh=/IoOmiKcEH0EgjtZoeJkmFuzTp8wuAKTOXKWZ0ShTCE=;
        h=Subject:References:From:To:Cc:Date:In-Reply-To:From;
        b=rFZlXA6WU4RZ87KzVnhfj+gHe8UG2LRiifn0UG+gMkrKl23q65mokQU0JBM1/sKQ8
         S0fyw+ZZkNhSKlzz/m+P7LXRVeyP0QVIp5yZ7Rw4lzUO6VpYycJwmlsDxi/Djjggm2
         LphGuT0elfoq+XVVaEP+5nr+lFrGiTagSDAKUi34=
Subject: Re: [PATCH] IMA: add an option to restrict the accepted hash
 algorithms
References: <1fcf5b7f-00bc-7963-cb9e-c7e7e8278c9b@viveris.fr>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     Simon.THOBY@viveris.fr
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Didier.BARVAUX@viveris.fr, linux-integrity@vger.kernel.org
Message-ID: <815b6955-02b8-b723-2c93-7b7ab83ea7e9@linux.microsoft.com>
Date:   Thu, 15 Jul 2021 22:36:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1fcf5b7f-00bc-7963-cb9e-c7e7e8278c9b@viveris.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Simon,

On 7/13/2021 7:48 AM, THOBY Simon wrote:

Since you had stated that this is your first kernel contribution, I 
wanted to give you some ideas on how to organize the code changes, how 
to write patch description, etc. I hope that helps.

> This patch was built on top of linux-5.14.0-rc1, and I successfully tested the patch
> in the following configurations:
> - disabled: no visible impact (as expected)
> - with ima_allowed_hashes=sha256,sha512:
> 	- alone: blocks both execution and xattr writes
> 	  (tested with `emvctl ima_hash -a md5 <my binary>`)
> 	- with ima_appraise=log: audit logs but still permits access
> 	- with ima_appraise=fix: audit logs but still permits access, however it
> 	  doesn't fix the hash (so maybe I should do something about it, because
> 	  right now it's basically the same as ima_appraise=log w.r.t. hash
> 	  algorithms ?)
> 	- with ima_accept_any_hash: permits access, no warnings whatsoever
> Do you want ideas of other configurations that I could test?

As Mimi had stated, you should split the code changes into smaller 
patches and include a cover letter for the patch set.

In the cover letter you can describe the problem you are addressing, 
provide the motivation for the change and a more detailed description of 
the feature.

And, in the individual patches describe the code changes specific to 
that patch.

Please take a look at the cover letter and patches in the patch set 
Tushar Sugandhi had authored for "measuring kernel integrity critical 
data using IMA" (Links given below):

https://lore.kernel.org/linux-integrity/20210108040708.8389-1-tusharsu@linux.microsoft.com/

https://patchwork.kernel.org/project/linux-integrity/patch/20210108040708.8389-2-tusharsu@linux.microsoft.com/

Split the code changes into smaller patches with each patch building on 
top of the previous patch(es). You can look at Tushar's patch set to get 
an idea on how to organize the patches in a logical way.

> 
> I would also like to point out that I'm more than open to suggestions for
> changing the names of the parameters (`ima_allowed_hashes` and
> `ima_accept_any_hash`) and the "cause" in the audit log (currently
> forbidden-hash-algorithm"), because as you know, "naming things is hard".
> 
> 
> IMA: add an option to restrict the accepted hash algorithms
> 
> Adds two command-line parameters to limit the hash algorithms
> allowed for the security.ima xattr. This gives users the
> ability to ensure their systems will not accept weak hashes,

The patch description should first state what the problem is that you 
are fixing. For example, the patch to "generalize keyring specific 
measurement constructs" states:

IMA functions such as ima_match_keyring(), process_buffer_measurement(),
ima_match_policy() etc.  handle data specific to keyrings.  Currently,
these constructs are not generic to handle any func specific data.
This makes it harder to extend them without code duplication.

Then, describe the change to address the issue. The patch description 
should be written in imperative style (as if you are issuing commands to 
do certain actions). For example, to address the above issue in the 
current code that makes it hard to extend without code duplication, what 
action is to be performed:

Refactor the keyring specific measurement constructs to be generic and
reusable in other measurement scenarios.

With respect to the actual code change, please look into the comment 
Mimi had given earlier (copied below from her email) on minimizing boot 
command line options:

Boot command line options should be minimized as much as possible.
Perhaps without defining new kernel boot paramaters there are some
additional checks that could be added.  For example, on a FIPS enabled
system, prevent writing non FIPS allowed file signatures, limit file
signature algorithms to those enabled on the system, define new policy
rules to limit the permitted hash algorithms.

thanks,
  -lakshmi

> and potentially increase users trust in their IMA configuration,
> because they can ensure only strong collision-resistant hashes
> are employed and files generated otherwise will not be accepted.
> 
> The main point is to safeguard users from mislabelling their files
> when using userland utilities to update their files, e.g. evmctl
> (`evmctl ima_hash` defaults to sha1). Another possible target
> would be people that have deployed IMA years ago, possibly using
> algorithms that was then deemed sufficiently collision-resistant,
> but that proved to be weak with the passage of time (note that this
> could also happen in the future with algorithms considered safe today).
> This patch also provides a migration path for users.
> 
> The first parameter supplies a list of allowed algorithms to
> the kernel, restricting appraisal to files hashed with "strong"
> hash algorithms (by default IMA will keep accepting any hash
> algorithm, as enabling such a feature by default would both be
> backward-incompatible and very probably break real systems).
> The second parameter is an escape hatch that adds a weaker form
> of backward-compatibility: when activated, IMA apparaisal will
> keep working on files hashed with an algorithm not present in
> the list, but updates to these files or new writes to the security.ima
> xattr will enforce the selected hash algorithms. This may be useful
> to perform an online migration from one algorithm to another.
> 
> 
> Signed-off-by: Simon Thoby <simon.thoby@viveris.fr>
> ---
>   .../admin-guide/kernel-parameters.txt         | 42 +++++++++
>   security/integrity/ima/ima.h                  |  6 +-
>   security/integrity/ima/ima_appraise.c         | 22 +++++
>   security/integrity/ima/ima_main.c             | 88 ++++++++++++++++++-
>   4 files changed, 156 insertions(+), 2 deletions(-)
