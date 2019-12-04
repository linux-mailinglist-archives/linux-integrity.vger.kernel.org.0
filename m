Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC6B3113824
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Dec 2019 00:25:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfLDXZv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 4 Dec 2019 18:25:51 -0500
Received: from mga06.intel.com ([134.134.136.31]:65086 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbfLDXZu (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 4 Dec 2019 18:25:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 15:25:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,278,1571727600"; 
   d="scan'208";a="208994240"
Received: from pminglan-mobl.amr.corp.intel.com ([10.251.2.222])
  by fmsmga007.fm.intel.com with ESMTP; 04 Dec 2019 15:25:49 -0800
Date:   Wed, 4 Dec 2019 15:25:48 -0800 (PST)
From:   Mat Martineau <mathew.j.martineau@linux.intel.com>
X-X-Sender: mjmartin@pminglan-mobl.amr.corp.intel.com
To:     Mimi Zohar <zohar@linux.ibm.com>
cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, eric.snowberg@oracle.com,
        dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org,
        jamorris@linux.microsoft.com, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org
Subject: Re: [PATCH v9 5/6] IMA: Add support to limit measuring keys
In-Reply-To: <1575458192.5241.99.camel@linux.ibm.com>
Message-ID: <alpine.OSX.2.21.1912041411100.45746@pminglan-mobl.amr.corp.intel.com>
References: <20191127015654.3744-1-nramas@linux.microsoft.com>  <20191127015654.3744-6-nramas@linux.microsoft.com>  <1575375945.5241.16.camel@linux.ibm.com>  <2d20ce36-e24e-e238-4a82-286db9eeab97@linux.microsoft.com>  <1575403616.5241.76.camel@linux.ibm.com>
  <89bb3226-3a2e-c7fa-fff9-3a422739481c@linux.microsoft.com> <1575458192.5241.99.camel@linux.ibm.com>
User-Agent: Alpine 2.21 (OSX 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1154282419-1575501949=:45746"
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1154282419-1575501949=:45746
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


On Wed, 4 Dec 2019, Mimi Zohar wrote:

> [Cc'ing Mat Martineau]
>
> On Tue, 2019-12-03 at 15:37 -0800, Lakshmi Ramasubramanian wrote:
>> On 12/3/2019 12:06 PM, Mimi Zohar wrote:
>>
>>> Suppose both root and uid 1000 define a keyring named "foo".  The
>>> current "keyrings=foo" will measure all keys added to either keyring
>>> named "foo".  There needs to be a way to limit measuring keys to a
>>> particular keyring named "foo".
>>>
>>> Mimi
>>
>> Thanks for clarifying.
>>
>> Suppose two different non-root users create keyring with the same name
>> "foo" and, say, both are measured, how would we know which keyring
>> measurement belongs to which user?
>>
>> Wouldn't it be sufficient to include only keyrings created by "root"
>> (UID value 0) in the key measurement? This will include all the builtin
>> trusted keyrings (such as .builtin_trusted_keys,
>> .secondary_trusted_keys, .ima, .evm, etc.).
>>
>> What would be the use case for including keyrings created by non-root
>> users in key measurement?
>>
>> Also, since the UID for non-root users can be any integer value (greater
>> than 0), can an an administrator craft a generic IMA policy that would
>> be applicable to all clients in an enterprise?
>
> The integrity subsystem, and other concepts upstreamed to support it,
> are being used by different people/companies in different ways.  I
> know some of the ways, but not all, as how it is being used.  For
> example, Mat Martineau gave an LSS2019-NA talk titled "Using and
> Implementing Keyring Restrictions for Userspace".  I don't know if he
> would be interested in measuring keys on these restricted userspace
> keyrings, but before we limit how a new feature works, we should at
> least look to see if that limitation is really necessary.

The use cases I'm most familiar with could have a use for key measurement 
for something like enterprise Wi-Fi root certificates. I'm not sure of the 
best way to uniquely identify a key to measure in that scenario, it could 
be anchored in various ways (process, session, thread, or user keyrings, 
for example) and may be owned by a non-root user. As Lakshmi noted above, 
key names are not unique, and I'll add that namespace considerations may 
come in to play too.

Keys (including keyrings like .builtin_trusted_keys, .ima, etc) can be 
linked to multiple keyrings, maybe you could create a system-level 
.ima_measured keyring. You could measure keys that are accessible from 
that keyring, and opt in more keys for measurement by linking them to 
.ima_measured or a keyring nested within .ima_measured.

--
Mat Martineau
Intel
--0-1154282419-1575501949=:45746--
