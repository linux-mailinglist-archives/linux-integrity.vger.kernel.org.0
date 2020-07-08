Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7992E2189EC
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jul 2020 16:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgGHORW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jul 2020 10:17:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729468AbgGHORV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jul 2020 10:17:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 068E2pkQ169935;
        Wed, 8 Jul 2020 10:17:20 -0400
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 325bew9240-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 10:17:19 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 068EAQ7B030139;
        Wed, 8 Jul 2020 14:17:18 GMT
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com [9.57.198.26])
        by ppma05wdc.us.ibm.com with ESMTP id 324yf9xa1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Jul 2020 14:17:18 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 068EHIaf14877592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jul 2020 14:17:18 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2843EAC05B;
        Wed,  8 Jul 2020 14:17:18 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15779AC059;
        Wed,  8 Jul 2020 14:17:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jul 2020 14:17:18 +0000 (GMT)
Subject: Re: [PATCH v9 2/2] tpm: Add support for event log pointer found in
 TPM2 ACPI table
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20200706181953.3592084-1-stefanb@linux.vnet.ibm.com>
 <20200706181953.3592084-3-stefanb@linux.vnet.ibm.com>
 <20200706230914.GC20770@linux.intel.com>
 <78ec872f-89b3-6464-6ede-bd0a46fe5c4c@linux.ibm.com>
 <20200707022416.GC112019@linux.intel.com>
 <f3e0fb50-8617-da40-1456-158531a070cb@linux.ibm.com>
 <20200707040325.GB143804@linux.intel.com>
 <85c27199-df55-eecc-855c-dedcea64f89e@linux.ibm.com>
 <20200708140753.GC538949@linux.intel.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <e42cb59d-6a3d-12be-bb51-88aa8c5dba23@linux.ibm.com>
Date:   Wed, 8 Jul 2020 10:17:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200708140753.GC538949@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-08_11:2020-07-08,2020-07-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 priorityscore=1501 cotscore=-2147483648 lowpriorityscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 spamscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007080099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/8/20 10:07 AM, Jarkko Sakkinen wrote:
> On Tue, Jul 07, 2020 at 12:09:11AM -0400, Stefan Berger wrote:
>> On 7/7/20 12:03 AM, Jarkko Sakkinen wrote:
>>> On Mon, Jul 06, 2020 at 11:08:12PM -0400, Stefan Berger wrote:
>>>> On 7/6/20 10:24 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, Jul 06, 2020 at 07:55:26PM -0400, Stefan Berger wrote:
>>>>>> On 7/6/20 7:09 PM, Jarkko Sakkinen wrote:
>>>>>>> On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
>>>>>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>>>
>>>>>>>> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
>>>>>>>> to get the event log from ACPI. If one is found, use it to get the
>>>>>>>> start and length of the log area. This allows non-UEFI systems, such
>>>>>>>> as SeaBIOS, to pass an event log when using a TPM2.
>>>>>>>>
>>>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>> Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
>>>>>>> way to test this?
>>>>>> Yes.
>>>>> Is the emulator bundled with QEMU or does it have to be installed
>>>>> separately?
>>>> It has to be installed separately. On Fedora 31 it would just be a `sudo dnf
>>>> -y install swtpm-tools` and you should be good to go with libvirt /
>>>> virt-manager.
>>> Is there some packaging for Debian/Ubuntu available?
>>
>> So far may not be available yet. I had *experimented* with a PPA once:
>> https://launchpad.net/~stefanberger/+archive/ubuntu/swtpm-focal
> There is a snap available:
>
> name:      swtpm-mvo
> summary:   Libtpms-based TPM emulator
> publisher: Michael Vogt (mvo)
> store-url: https://snapcraft.io/swtpm-mvo
> license:   unset
> description: |
>    Libtpms-based TPM emulator with socket, character device, and Linux
>    CUSE interface.
> commands:
>    - swtpm-mvo.swtpm
> services:
>    swtpm-mvo.swtpm-sock: simple, enabled, active
> snap-id:      HNl1TwHRBk3OtXQ8OriRB93FDZ6vman7
> tracking:     latest/edge
> refresh-date: today at 02:05 EEST
> channels:
>    latest/stable:    –
>    latest/candidate: –
>    latest/beta:      0.1.0 2019-07-26 (11) 3MB -
>    latest/edge:      0.1.0 2020-07-08 (75) 3MB -
> installed:          0.1.0            (74) 3MB -
>
> This is the version information:
>
> ❯ swtpm-mvo.swtpm --version
> TPM emulator version 0.4.0, Copyright (c) 2014 IBM Corp.
>
> However, if I try to run the first example from [*], I get:
>
> ❯ swtpm-mvo.swtpm socket --tpmstate dir=/tmp/mytpm1 \
>    --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
>    --log level=20
> swtpm: Could not open UnixIO socket: No such file or directory


Did you create the directory '/tmp/mytpm1' ?


> [*] https://www.qemu.org/docs/master/specs/tpm.html
>
> /Jarkko


