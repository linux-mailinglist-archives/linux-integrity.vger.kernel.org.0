Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C3CA6D56
	for <lists+linux-integrity@lfdr.de>; Tue,  3 Sep 2019 17:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfICPyw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 3 Sep 2019 11:54:52 -0400
Received: from linux.microsoft.com ([13.77.154.182]:45092 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbfICPyw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 3 Sep 2019 11:54:52 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7249B20B7186;
        Tue,  3 Sep 2019 08:54:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7249B20B7186
Subject: Re: [PATCH 0/1] KEYS: Measure keys in trusted keyring
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Matthew Garrett <mjg59@google.com>
Cc:     jamorris@linux.microsoft.com, sashal@kernel.org,
        kgoldman@us.ibm.com,
        "Wiseman, Monty (GE Global Research, US)" <monty.wiseman@ge.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
References: <20190828002735.31025-1-nramas@linux.microsoft.com>
 <1567041083.6115.133.camel@linux.ibm.com>
 <ec8d7cd5-a83a-c344-eaa6-9bd2cef08772@linux.microsoft.com>
 <1567190507.10024.134.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2cd27f52-1029-bcea-c73b-7d3d002cf030@linux.microsoft.com>
Date:   Tue, 3 Sep 2019 08:54:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567190507.10024.134.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/30/19 11:41 AM, Mimi Zohar wrote:

> No, the measurement list ima-sig template record contains both the
> file hash and signature.  There's no need to maintain a white list of
> either the file hashes or signed hashes.  All that is needed is the
> set of permitted public keys (eg. keys on the trusted IMA keyring).

You are right - Thanks for the info.

> Even though on the local system, files signed by the system owner
> would be permitted, the attestation server would be able to control
> access to whatever service.  For example, Trusted Network Connect
> (TNC) could control network access.  By measuring the keys on the
> builtin/secondary keyrings, that control is not based on who signed
> the software package, but based on who signed the certificate of the
> key that signed the software package.  My concern is how this level of
> indirection could be abused.
Since the signer of certificate of the key that signed the software 
package changes much less frequently compared to the certificate of the 
key used to sign the software package, the operational overhead on the 
server side is significantly reduced.

I understand there is another level of indirection here. But I am also 
not clear how this can be abused.

> All of this would still be true, if you measured the keys on the
> trusted IMA keyring, but without the level of indirection described
> above.  Depending on your use case scenario, the problem with this
> approach is maintaining a list of all the certificates that have been
> signed by keys on the builtin, and if enabled, the secondary keyrings.

Yes - that is the issue we are trying to avoid. Especially since the 
list of signing certificates can grow faster than the signer of those 
certificates (that are present in the builtin/secondary keyrings)

> In the last LSS-NA BoF, Monty suggested, for a different use case, one
> that needs to seal keys, measuring keys and extending a separate PCR.
Thanks for the info. I will gather more information on this one.

  -lakshmi

