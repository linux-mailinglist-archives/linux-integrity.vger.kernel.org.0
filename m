Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8685D532ECB
	for <lists+linux-integrity@lfdr.de>; Tue, 24 May 2022 18:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbiEXQTM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 May 2022 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbiEXQTM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 May 2022 12:19:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776706351B;
        Tue, 24 May 2022 09:19:11 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24OFfjdv016583;
        Tue, 24 May 2022 16:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=aGeOnOLLgA5FA6U32gLZpU1eltA+Hcdxh7v+Umar3OQ=;
 b=euS4Pb6I2+VJRkWR+ADgF5K4BtcTSFJL+TsvOXN8hZlv54WxQ8Ia/86xbNEru3+YNb48
 EKVC2C6cVUAoIqt0JPhIPc3SqkGITAuZg7A8BQq7jVLCu5YIuamlzEXbYdPPG8ovNcGZ
 rjxoM7mfVG+u1dfW35VqYnmhebFHKpQJBYOHQvQ07vusbSTlZLXtAxa8jhbRiACHSbsc
 aPNnbFbAM8jUhtcxFpj3j5RRpYXgRd0z63xfv/o7sbzPPu7PZzVuJ3+7PK1d8LBpVc/l
 Y2w4vB5jqE9d5y2GHQ380SdTSIuS2/vSrSeHMcNLLTlApKKFb4mS0n+vSPMWvUbLrw3T yw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g927urwsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:18:47 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24OFhPDC025487;
        Tue, 24 May 2022 16:18:46 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g927urws8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:18:46 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24OGEBHG023958;
        Tue, 24 May 2022 16:18:45 GMT
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
        by ppma02wdc.us.ibm.com with ESMTP id 3g6qqa18p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 16:18:45 +0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com [9.57.199.111])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24OGIixp26411308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 May 2022 16:18:44 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2360DAC064;
        Tue, 24 May 2022 16:18:44 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0385CAC05B;
        Tue, 24 May 2022 16:18:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 24 May 2022 16:18:43 +0000 (GMT)
Message-ID: <8ba32888-32ad-cf92-49e6-15d432331bba@linux.ibm.com>
Date:   Tue, 24 May 2022 12:18:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v12 03/26] ima: Define ima_namespace struct and start
 moving variables into it
Content-Language: en-US
To:     "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        christian.brauner@ubuntu.com, containers@lists.linux.dev,
        dmitry.kasatkin@gmail.com, ebiederm@xmission.com,
        krzysztof.struczynski@huawei.com, roberto.sassu@huawei.com,
        mpeters@redhat.com, lhinds@redhat.com, lsturman@redhat.com,
        puiterwi@redhat.com, jejb@linux.ibm.com, jamjoom@us.ibm.com,
        linux-kernel@vger.kernel.org, paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        jpenumak@redhat.com, Christian Brauner <brauner@kernel.org>
References: <20220420140633.753772-1-stefanb@linux.ibm.com>
 <20220420140633.753772-4-stefanb@linux.ibm.com>
 <20220521023351.GA9107@mail.hallyn.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220521023351.GA9107@mail.hallyn.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JB2PU8b-sqUlLgmdDFMyOsc4ij0AaY6t
X-Proofpoint-GUID: RBA7ti0NQe8McmWcSGKxqe_nf9FzM4sY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-24_07,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205240080
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 5/20/22 22:33, Serge E. Hallyn wrote:

>>    * they make a queue.  The policy may be updated multiple times and this is the
>> @@ -985,16 +988,17 @@ int ima_check_policy(void)
>>    * Policy rules are never deleted so ima_policy_flag gets zeroed only once when
>>    * we switch from the default policy to user defined.
>>    */
>> -void ima_update_policy(void)
>> +void ima_update_policy(struct ima_namespace *ns)
>>   {
>> -	struct list_head *policy = &ima_policy_rules;
>> +	struct list_head *policy = &ns->ima_policy_rules;
>>   
>> -	list_splice_tail_init_rcu(&ima_temp_rules, policy, synchronize_rcu);
>> +	list_splice_tail_init_rcu(&ns->ima_temp_rules, policy,
>> +				  synchronize_rcu);
>>   
>> -	if (ima_rules != (struct list_head __rcu *)policy) {
>> -		ima_policy_flag = 0;
>> +	if (ns->ima_rules != (struct list_head __rcu *)policy) {
>> +		ns->ima_policy_flag = 0;
>>   
>> -		rcu_assign_pointer(ima_rules, policy);
>> +		rcu_assign_pointer(ns->ima_rules, policy);
>>   		/*
>>   		 * IMA architecture specific policy rules are specified
>>   		 * as strings and converted to an array of ima_entry_rules
>> @@ -1003,10 +1007,10 @@ void ima_update_policy(void)
>>   		 */
>>   		kfree(arch_policy_entry);
>>   	}
>> -	ima_update_policy_flags();
>> +	ima_update_policy_flags(ns);
>>   
>>   	/* Custom IMA policy has been loaded */
>> -	ima_process_queued_keys();
>> +	ima_process_queued_keys(ns);
>>   }
>>   

So this is a caller that may enter that function with ns != init_ima_ns 
and in that case that function should do nothing. So, also the WARN_ON() 
is not appropriate then.

    Stefan
