Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D71E2CF75
	for <lists+linux-integrity@lfdr.de>; Tue, 28 May 2019 21:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbfE1T1g (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 May 2019 15:27:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47014 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727795AbfE1T1f (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 May 2019 15:27:35 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4SJOrx5056837
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:27:34 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ss94bdagp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 28 May 2019 15:27:34 -0400
Received: from localhost
        by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.ibm.com>;
        Tue, 28 May 2019 20:27:33 +0100
Received: from b03cxnp08025.gho.boulder.ibm.com (9.17.130.17)
        by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 May 2019 20:27:28 +0100
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4SJRRNP22282730
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 May 2019 19:27:27 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C0A6BE053;
        Tue, 28 May 2019 19:27:27 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D76FDBE058;
        Tue, 28 May 2019 19:27:22 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.85.218.160])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
        Tue, 28 May 2019 19:27:22 +0000 (GMT)
References: <20190418035120.2354-1-bauerman@linux.ibm.com> <20190418035120.2354-10-bauerman@linux.ibm.com> <1557835765.4139.9.camel@linux.ibm.com>
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
In-reply-to: <1557835765.4139.9.camel@linux.ibm.com>
Date:   Tue, 28 May 2019 16:27:17 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
x-cbid: 19052819-0004-0000-0000-000015154B13
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011176; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01209921; UDB=6.00635635; IPR=6.00990951;
 MB=3.00027089; MTD=3.00000008; XFM=3.00000015; UTC=2019-05-28 19:27:32
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19052819-0005-0000-0000-00008BD76A03
Message-Id: <87y32q5qi2.fsf@morokweng.localdomain>
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
> On Thu, 2019-04-18 at 00:51 -0300, Thiago Jung Bauermann wrote:
>> 
>> @@ -326,6 +356,10 @@ int ima_appraise_measurement(enum ima_hooks func,
>> case INTEGRITY_UNKNOWN:
>> break;
>> case INTEGRITY_NOXATTRS:/* No EVM protected xattrs. */
>> +/* It's fine not to have xattrs when using a modsig. */
>> +if (try_modsig)
>> +break;
>> +/* fall through */
>> case INTEGRITY_NOLABEL:/* No security.evm xattr. */
>> cause = "missing-HMAC";
>> goto out;
>> @@ -340,6 +374,14 @@ int ima_appraise_measurement(enum ima_hooks func,
>> rc = xattr_verify(func, iint, xattr_value, xattr_len, &status,
>>  &cause);
>> 
>> +/*
>> + * If we have a modsig and either no imasig or the imasig's key isn't
>> + * known, then try verifying the modsig.
>> + */
>> +if (status != INTEGRITY_PASS && try_modsig &&
>> + (!xattr_value || rc == -ENOKEY))
>> +rc = modsig_verify(func, modsig, &status, &cause);
>
> EVM protects other security xattrs, not just security.ima, if they
> exist. As a result, evm_verifyxattr() could pass based on the other
> security xattrs.

Indeed! It doesn't make sense to test for status != INTEGRITY_PASS here.
Not sure what I was thinking. Thanks for spotting it. With your other
comments about this if clause, this code now reads:

	/*
	 * If we have a modsig and either no imasig or the imasig's key isn't
	 * known, then try verifying the modsig.
	 */
	if (try_modsig &&
	    (!xattr_value || xattr_value->type == IMA_XATTR_DIGEST_NG ||
	     rc == -ENOKEY))
		rc = modsig_verify(func, modsig, &status, &cause);

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

