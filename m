Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4AB21651B
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 06:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgGGEJP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 7 Jul 2020 00:09:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17568 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgGGEJO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 7 Jul 2020 00:09:14 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06741rt4112843;
        Tue, 7 Jul 2020 00:09:13 -0400
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32486cdutp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 00:09:13 -0400
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0673xPjL028027;
        Tue, 7 Jul 2020 04:09:12 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma02dal.us.ibm.com with ESMTP id 322hd922tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 04:09:12 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06749Bs045678944
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 04:09:11 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A57BDAC062;
        Tue,  7 Jul 2020 04:09:11 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 93B8FAC05F;
        Tue,  7 Jul 2020 04:09:11 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 04:09:11 +0000 (GMT)
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
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <85c27199-df55-eecc-855c-dedcea64f89e@linux.ibm.com>
Date:   Tue, 7 Jul 2020 00:09:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200707040325.GB143804@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007070025
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/7/20 12:03 AM, Jarkko Sakkinen wrote:
> On Mon, Jul 06, 2020 at 11:08:12PM -0400, Stefan Berger wrote:
>> On 7/6/20 10:24 PM, Jarkko Sakkinen wrote:
>>> On Mon, Jul 06, 2020 at 07:55:26PM -0400, Stefan Berger wrote:
>>>> On 7/6/20 7:09 PM, Jarkko Sakkinen wrote:
>>>>> On Mon, Jul 06, 2020 at 02:19:53PM -0400, Stefan Berger wrote:
>>>>>> From: Stefan Berger <stefanb@linux.ibm.com>
>>>>>>
>>>>>> In case a TPM2 is attached, search for a TPM2 ACPI table when trying
>>>>>> to get the event log from ACPI. If one is found, use it to get the
>>>>>> start and length of the log area. This allows non-UEFI systems, such
>>>>>> as SeaBIOS, to pass an event log when using a TPM2.
>>>>>>
>>>>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>>>> Do you think that QEMU with TPM 1.2 emulator turned on would be a viable
>>>>> way to test this?
>>>> Yes.
>>> Is the emulator bundled with QEMU or does it have to be installed
>>> separately?
>> It has to be installed separately. On Fedora 31 it would just be a `sudo dnf
>> -y install swtpm-tools` and you should be good to go with libvirt /
>> virt-manager.
> Is there some packaging for Debian/Ubuntu available?


So far may not be available yet. I had *experimented* with a PPA once: 
https://launchpad.net/~stefanberger/+archive/ubuntu/swtpm-focal



> /Jarkko


