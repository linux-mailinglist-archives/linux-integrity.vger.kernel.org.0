Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18343317379
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Feb 2021 23:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233711AbhBJWg2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 10 Feb 2021 17:36:28 -0500
Received: from linux.microsoft.com ([13.77.154.182]:39582 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbhBJWgL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 10 Feb 2021 17:36:11 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 04C8120B6C40;
        Wed, 10 Feb 2021 14:34:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04C8120B6C40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1612996499;
        bh=C4RT2DxXX8r0QxWsc1tHKf/MPo20abgRwaNI176DYPI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=onouFjqolPpuZU+smvyVOWVYonhp8wE62mGs4xFoCMBc41e1Qh93K7Mi9KTvGbtmN
         UAzqFqtJBtcopTyxJ1GQNHoEHiXrWLeTs8SeDEQWYK2LTomPeu/bu09ptLZCtKjF1l
         qJESL6CaYdPTWm0FK8vjjxpDP90Z9TdzZbUyzDZo=
Subject: Re: [PATCH v17 00/10] Carry forward IMA measurement log on kexec on
 ARM64
To:     Mimi Zohar <zohar@linux.ibm.com>, Rob Herring <robh@kernel.org>
Cc:     Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        "AKASHI, Takahiro" <takahiro.akashi@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>, Joe Perches <joe@perches.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        James Morse <james.morse@arm.com>,
        Sasha Levin <sashal@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Frank Rowand <frowand.list@gmail.com>,
        vincenzo.frascino@arm.com, Mark Rutland <mark.rutland@arm.com>,
        dmitry.kasatkin@gmail.com, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Allison Randal <allison@lohutok.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>, tao.li@vivo.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
References: <20210209182200.30606-1-nramas@linux.microsoft.com>
 <20210210171500.GA2328209@robh.at.kernel.org>
 <5c002c32-bc49-acda-c641-7b1494ea292d@linux.microsoft.com>
 <CAL_JsqLmdqfFF8u=dE+dQz+6ngv=moWkQF8tpZjUCX-vHuvU_w@mail.gmail.com>
 <cf7930239b93044a1be353556b7dc730e024f658.camel@linux.ibm.com>
 <594445d01e085875b97b46be726247f89d1e6661.camel@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <82fec498-b1c0-7acd-cf1e-8bb40a4e688e@linux.microsoft.com>
Date:   Wed, 10 Feb 2021 14:34:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <594445d01e085875b97b46be726247f89d1e6661.camel@linux.ibm.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 2/10/21 1:39 PM, Mimi Zohar wrote:
> On Wed, 2021-02-10 at 15:55 -0500, Mimi Zohar wrote:
>> On Wed, 2021-02-10 at 14:42 -0600, Rob Herring wrote:
>>> On Wed, Feb 10, 2021 at 11:33 AM Lakshmi Ramasubramanian
>>
>>> Ideally, we don't apply the same patch in 2 branches. It looks like
>>> there's a conflict but no real dependence on the above patch (the
>>> ima_buffer part). The conflict seems trivial enough that Linus can
>>> resolve it in the merge window.
>>>
>>> Or Mimi can take the whole thing if preferred?
>>
>> How about I create a topic branch with just the two patches, allowing
>> both of us to merge it?   There shouldn't be a problem with re-writing
>> next-integrity history.
> 
> The 2 patches are now in the ima-kexec-fixes branch.
> 

Thanks a lot Mimi.

Rob - I will address the 2 comments you'd provided today, and build the 
patches in ima-kexec-fixes branch.

If you have more comments in the v17 patches, please let me know.

thanks,
  -lakshmi

