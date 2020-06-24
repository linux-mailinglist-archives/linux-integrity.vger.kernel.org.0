Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C9207E52
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jun 2020 23:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390317AbgFXVSD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 24 Jun 2020 17:18:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389773AbgFXVSC (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 24 Jun 2020 17:18:02 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05OL2eA1069618;
        Wed, 24 Jun 2020 17:17:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwymyggj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 17:17:55 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05OLHsef143482;
        Wed, 24 Jun 2020 17:17:54 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31uwymygg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 17:17:54 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05OLG6IB020242;
        Wed, 24 Jun 2020 21:17:53 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma04wdc.us.ibm.com with ESMTP id 31uury6ufj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Jun 2020 21:17:53 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05OLHqs544433764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Jun 2020 21:17:52 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD99D112061;
        Wed, 24 Jun 2020 21:17:52 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 95B4E112064;
        Wed, 24 Jun 2020 21:17:52 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 24 Jun 2020 21:17:52 +0000 (GMT)
Subject: Re: [PATCH v2] ima_evm_utils: extended calc_bootaggr to PCRs 8 - 9
To:     Bruno Meneguele <bmeneg@redhat.com>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Cc:     zohar@linux.ibm.com, Silviu.Vlasceanu@huawei.com,
        dmitry.kasatkin@gmail.com, jejb@linux.ibm.com, jmorris@namei.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, mdrocco@linux.vnet.ibm.com,
        roberto.sassu@huawei.com, serge@hallyn.com
References: <1592856871.4987.21.camel@linux.ibm.com>
 <20200623180122.209-1-maurizio.drocco@ibm.com> <20200623181357.GC4983@glitch>
From:   Stefan Berger <stefanb@linux.ibm.com>
Message-ID: <92a0d170-8157-476b-8083-ae567b11f364@linux.ibm.com>
Date:   Wed, 24 Jun 2020 17:17:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200623181357.GC4983@glitch>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-24_16:2020-06-24,2020-06-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 cotscore=-2147483648 spamscore=0 malwarescore=0 adultscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 phishscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 mlxscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006240133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 6/23/20 2:13 PM, Bruno Meneguele wrote:
> On Tue, Jun 23, 2020 at 02:01:22PM -0400, Maurizio Drocco wrote:
>> From: Maurizio <maurizio.drocco@ibm.com>
>>
>> If PCRs 8 - 9 are set (i.e. not all-zeros), cal_bootaggr should include
>> them into the digest.


Wouldn't you have to check for not all-zeros in your code?


    Stefan


>>
>> Signed-off-by: Maurizio Drocco <maurizio.drocco@ibm.com>
>> ---
>> Changelog:
>> v2:
>> - Always include PCRs 8 & 9 to non-sha1 hashes
>> v1:
>> - Include non-zero PCRs 8 & 9 to boot aggregates
>>
>>   src/evmctl.c | 15 +++++++++++++--
>>   1 file changed, 13 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/evmctl.c b/src/evmctl.c
>> index 1d065ce..46b7092 100644
>> --- a/src/evmctl.c
>> +++ b/src/evmctl.c
>> @@ -1930,6 +1930,16 @@ static void calc_bootaggr(struct tpm_bank_info *bank)
>>   		}
>>   	}
>>   
>> +	if (strcmp(bank->algo_name, "sha1") != 0) {
>> +		for (i = 8; i < 10; i++) {
>> +			err = EVP_DigestUpdate(pctx, bank->pcr[i], bank->digest_size);
>> +			if (!err) {
>> +				log_err("EVP_DigestUpdate() failed\n");
>> +				return;
>> +			}
>> +		}
>> +	}
>> +
>>   	err = EVP_DigestFinal(pctx, bank->digest, &mdlen);
>>   	if (!err) {
>>   		log_err("EVP_DigestFinal() failed\n");
>> @@ -1972,8 +1982,9 @@ static int append_bootaggr(char *bootaggr, struct tpm_bank_info *tpm_banks)
>>   /*
>>    * The IMA measurement list boot_aggregate is the link between the preboot
>>    * event log and the IMA measurement list.  Read and calculate all the
>> - * possible per TPM bank boot_aggregate digests based on the existing
>> - * PCRs 0 - 7 to validate against the IMA boot_aggregate record.
>> + * possible per TPM bank boot_aggregate digests based on the existing PCRs
>> + * 0 - 9 to validate against the IMA boot_aggregate record. If the digest
>> + * algorithm is SHA1, only PCRs 0 - 7 are considered to avoid ambiguity.
>>    */
>>   static int cmd_ima_bootaggr(struct command *cmd)
>>   {
>> -- 
>> 2.17.1
>>
> Reviewed-by: Bruno Meneguele <bmeneg@redhat.com>
>

