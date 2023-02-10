Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12F369293E
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Feb 2023 22:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbjBJV25 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Feb 2023 16:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbjBJV24 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Feb 2023 16:28:56 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735C67BFF9;
        Fri, 10 Feb 2023 13:28:55 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31ALHrYB013876;
        Fri, 10 Feb 2023 21:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=i2L7Ia8mK7A5ZkFcCIDcuqRFhX3LFkYSRraV5RpB/N0=;
 b=pYVlD6QBILIm2kSaLn86Yx8Z7cytyyPO+/ivIlFqFyqemYON8IczZAqX3Hsn+jCQpoMp
 rPyWdp6kEP5iX+NRJBmfR4KTE04wtUsUpLj7nlIf1aRqFnCNdnxo8Fz/OlNNQ1ZG7RZ+
 zrpkMtcsbSUWP4LRGjIyDfeQNnSoE47RvB2SG3O5udjiooewWgvCGdw9WUa3X0WS7wmU
 /fOZwkLDJ2NVIxMVJk5zi6HhsLJmgSzpUzvLhI7I61Ri9+K4OdNfVTuEo0iS81VXixPR
 3qb6VfzMmGjCEc26e7vPpsg0FK+zqJzOIFi+56gtNL9TzVWQD1D1+YUKv1dWugoAcKdJ Fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnwqf86yy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 21:28:46 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31ALNX1M032059;
        Fri, 10 Feb 2023 21:28:45 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnwqf86yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 21:28:45 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31AJ23mu017625;
        Fri, 10 Feb 2023 21:28:44 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([9.208.130.102])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3nhf0890g0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 21:28:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31ALShbT7602810
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 21:28:43 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBE8F58054;
        Fri, 10 Feb 2023 21:28:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66E6558050;
        Fri, 10 Feb 2023 21:28:41 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 10 Feb 2023 21:28:41 +0000 (GMT)
Message-ID: <a63276d5-1be4-b140-6a4a-4ad4efa60eda@linux.ibm.com>
Date:   Fri, 10 Feb 2023 16:28:40 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 24/26] powerpc/pseries: Implement secvars for dynamic
 secure boot
Content-Language: en-US
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, ruscur@russell.cc, joel@jms.id.au,
        bgray@linux.ibm.com, brking@linux.ibm.com, gcwilson@linux.ibm.com
References: <20230210080401.345462-1-ajd@linux.ibm.com>
 <20230210080401.345462-25-ajd@linux.ibm.com>
 <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
In-Reply-To: <f35e9ba1-5fdb-4cfa-5b41-cc55307dcd45@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EAs5PgRdluiiEpYwXP300TK4RVeRSB_e
X-Proofpoint-ORIG-GUID: EUsq-Nrm3brOT4M4ZheaLuvRfA5l5fq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=995 bulkscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302100179
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 2/10/23 16:23, Stefan Berger wrote:
> 
> 

>> +
>> +// PLPKS dynamic secure boot doesn't give us a format string in the same way OPAL does.
>> +// Instead, report the format using the SB_VERSION variable in the keystore.
>> +// The string is made up by us, and takes the form "ibm,plpks-sb-v<n>" (or "ibm,plpks-sb-unknown"
>> +// if the SB_VERSION variable doesn't exist). Hypervisor defines the SB_VERSION variable as a
>> +// "1 byte unsigned integer value".
>> +static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
>> +{
>> +    struct plpks_var var = {0};
>> +    ssize_t ret;
>> +    u8 version;
>> +
>> +    var.component = NULL;
> 
> Since it's initialized with {0} this is not necessary.
> 
>> +    // Only the signed variables have null bytes in their names, this one doesn't
>> +    var.name = "SB_VERSION";
>> +    var.namelen = strlen(var.name);
>> +    var.datalen = 1;
>> +    var.data = &version;
>> +
>> +    // Unlike the other vars, SB_VERSION is owned by firmware instead of the OS
>> +    ret = plpks_read_fw_var(&var);
>> +    if (ret) {
>> +        if (ret == -ENOENT) {
>> +            ret = snprintf(buf, bufsize, "ibm,plpks-sb-unknown");
>> +        } else {
>> +            pr_err("Error %ld reading SB_VERSION from firmware\n", ret);
>> +            ret = -EIO;
>> +        }
>> +        goto err;
>> +    }
>> +
>> +    ret = snprintf(buf, bufsize, "ibm,plpks-sb-v%hhu", version);
>> +
>> +err:
>> +    kfree(var.data);
> 
> remove the kfree()

Actually don't remove it but it should probably be

if (var.data != &version)
     kfree(var.data);
> 
>> +    return ret;
>> +}
>> +
