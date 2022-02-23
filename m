Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD204C1E7C
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Feb 2022 23:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243948AbiBWWbi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Feb 2022 17:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243960AbiBWWbe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Feb 2022 17:31:34 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE52C4DF79;
        Wed, 23 Feb 2022 14:31:02 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NK72Hu011610;
        Wed, 23 Feb 2022 22:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JXMEhzdQEShEpeIOkqJCin6BAf5GSfTvsNdcahqU9Ss=;
 b=bzAZ9m0j5orOakeXKqsoGMA/+eXd7+GQOIgGwX11xsS1KnGpdgg13GIMOMv+bpJOStxq
 C48WwNGVSHhSvVBROfJIUeUecvu2JByX6Nt9sr6ACLDpWt/sXBmbmGk1zFFD5ITPyc0u
 euMR7tAzaRWOxdS7f5sF5yNMZTpHXHihIOU+Us48hBe/6e65DvFos76xXEXhQXTai/kT
 obsLKJ1mIxiBvYsGY8N8LfW+DTtk/2M89IKfBRIKsse22spFyFD5JgynLskjHFeH7otM
 JzaYh/38NEAdk7svBWuoPECzGi5gdwffIBUS7DXkbYkf3CFUvL6s/t4P4emQfPdh9mzz 6A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eds7967tn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 22:30:46 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21NMLse7025567;
        Wed, 23 Feb 2022 22:30:45 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3eds7967tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 22:30:45 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21NME6j6023396;
        Wed, 23 Feb 2022 22:30:44 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma02wdc.us.ibm.com with ESMTP id 3ear6asxjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 22:30:44 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21NMUecb19726704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 22:30:40 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5919C124058;
        Wed, 23 Feb 2022 22:30:40 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E92CE12405B;
        Wed, 23 Feb 2022 22:30:39 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 23 Feb 2022 22:30:39 +0000 (GMT)
Message-ID: <0a3d75a9-bc04-cf72-6719-4c3b4c8cc880@linux.ibm.com>
Date:   Wed, 23 Feb 2022 17:30:39 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v10 24/27] ima: Introduce securityfs file to activate an
 IMA namespace
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc:     serge@hallyn.com, christian.brauner@ubuntu.com,
        containers@lists.linux.dev, dmitry.kasatkin@gmail.com,
        ebiederm@xmission.com, krzysztof.struczynski@huawei.com,
        roberto.sassu@huawei.com, mpeters@redhat.com, lhinds@redhat.com,
        lsturman@redhat.com, puiterwi@redhat.com, jejb@linux.ibm.com,
        jamjoom@us.ibm.com, linux-kernel@vger.kernel.org,
        paul@paul-moore.com, rgb@redhat.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org
References: <20220201203735.164593-1-stefanb@linux.ibm.com>
 <20220201203735.164593-25-stefanb@linux.ibm.com>
 <9a720bf5928151a0cbc7994ee498a1c3ca779c56.camel@linux.ibm.com>
 <9262a630-1f3e-0f58-110d-abfebe8274af@linux.ibm.com>
 <6e5d6ab590f18e6ee57c9e6e4bb805c8c223259a.camel@linux.ibm.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6e5d6ab590f18e6ee57c9e6e4bb805c8c223259a.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jz_K_F6DBIFGNEzXPbewR9hh8532VTOI
X-Proofpoint-ORIG-GUID: ae640DadsXixPh9BRUEsxYaWUsaMT0Id
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-23_09,2022-02-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 impostorscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202230124
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 2/23/22 12:12, Mimi Zohar wrote:
> On Wed, 2022-02-23 at 12:08 -0500, Stefan Berger wrote:
>> On 2/23/22 08:54, Mimi Zohar wrote:
>>> On Tue, 2022-02-01 at 15:37 -0500, Stefan Berger wrote:
>>>
>>>>    int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>>>>    {
>>>>    	struct ima_namespace *ns = ima_ns_from_user_ns(user_ns);
>>>> @@ -531,6 +596,12 @@ int ima_fs_ns_init(struct user_namespace *user_ns, struct dentry *root)
>>>>    		}
>>>>    	}
>>>>    
>>>> +	if (ns != &init_ima_ns) {
>>>> +		ret = ima_fs_add_ns_files(ima_dir);
>>>> +		if (ret)
>>>> +			goto out;
>>>> +	}
>>>> +
>>> In all other cases, the securityfs files are directly created in
>>> ima_fs_ns_init().   What is different about "active" that a new
>>> function is defined?
>>
>> It was meant as a function to create namespace-specific files, if more
>> were to come along.  I can move the code from ima_fs_add_ns_files() into
>> this function if you want.
> Perhaps defer defining a new function until that happens.

I moved the code out of this function into ima_fs_ns_init() now.



