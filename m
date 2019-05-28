Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F63A2CF6A
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2019 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbfE1TYn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 15:24:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727291AbfE1TYn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 15:24:43 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SJOXtd146011
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:24:42 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ssb2yr303-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:24:36 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 May 2019 20:23:30 +0100
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 20:23:25 +0100
Received: from b01ledav005.gho.pok.ibm.com (b01ledav005.gho.pok.ibm.com [9.57.199.110])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SJNOSg34275810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:23:24 GMT
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59697AE05C;
        Tue, 28 May 2019 19:23:24 +0000 (GMT)
Received: from b01ledav005.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BF17AE060;
        Tue, 28 May 2019 19:23:20 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.218.160])
        by b01ledav005.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 28 May 2019 19:23:20 +0000 (GMT)
References: <20190418035120.2354-1-bauerman@linux.ibm.com> <20190418035120.2354-10-bauerman@linux.ibm.com> <1557442868.10635.87.camel@linux.ibm.com>
User-agent: mu4e 1.0; emacs 26.2
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v10 09/12] ima: Implement support for module-style appended signatures
In-reply-to: <1557442868.10635.87.camel@linux.ibm.com>
Date:   Tue, 28 May 2019 16:23:16 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052819-0060-0000-0000-00000348F66C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011176; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209920; UDB=6.00635634; IPR=6.00990949;
 MB=3.00027089; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-28 19:23:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052819-0061-0000-0000-000049888DD2
Message-Id: <87zhn65qor.fsf@morokweng.localdomain>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905280121
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Mimi Zohar <zohar@linux.ibm.com> writes:

> Hi Thiago,
>
>> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
>> index fca7a3f23321..a7a20a8c15c1 100644
>> --- a/security/integrity/ima/ima_policy.c
>> +++ b/security/integrity/ima/ima_policy.c
>> @@ -1144,6 +1144,12 @@ void ima_delete_rules(void)
>>  	}
>>  }
>>
>> +#define __ima_hook_stringify(str)	(#str),
>> +
>> +const char *const func_tokens[] = {
>> +	__ima_hooks(__ima_hook_stringify)
>> +};
>> +
>>  #ifdef	CONFIG_IMA_READ_POLICY
>>  enum {
>>  	mask_exec = 0, mask_write, mask_read, mask_append
>> @@ -1156,12 +1162,6 @@ static const char *const mask_tokens[] = {
>>  	"MAY_APPEND"
>>  };
>>
>> -#define __ima_hook_stringify(str)	(#str),
>> -
>> -static const char *const func_tokens[] = {
>> -	__ima_hooks(__ima_hook_stringify)
>> -};
>> -
>>  void *ima_policy_start(struct seq_file *m, loff_t *pos)
>>  {
>>  	loff_t l = *pos;
>
> Is moving this something left over from previous versions or there is
> a need for this change?

Well, it's not a strong need, but it's still relevant in the current
version. I use func_tokens in ima_read_modsig() in order to be able to
mention the hook name in mod_check_sig()'s error message:

In ima_read_modsig():

	rc = mod_check_sig(sig, buf_len, func_tokens[func]);

And in mod_check_sig():

		pr_err("%s: Module is not signed with expected PKCS#7 message\n",
		       name);

If you think it's not worth it to expose func_tokens, I can make
ima_read_modsig() pass a more generic const string such as "IMA modsig"
for example.

> Other than this, the patch looks good.

Nice!

--
Thiago Jung Bauermann
IBM Linux Technology Center

