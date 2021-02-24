Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E45B3234FD
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Feb 2021 02:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbhBXBKs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 Feb 2021 20:10:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25264 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230434AbhBXAqe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 Feb 2021 19:46:34 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11O0buQd108082;
        Tue, 23 Feb 2021 19:44:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=p0+iy1yvH3oxZuR/LojE78fT6Hikgd+uRSImxD1mTfY=;
 b=OuvSCGXnpgIa+m1wJw5P+W5TLVZthNzZT7DqQb0alny0GOgUQNyrUO+cT8MF2AN9HPq2
 evq+4tkwZpyPXp2MP6EzkjPwDtJz9cBdi6oYq0NhSx7/UTq9M4nBTANBIBMivDhDcUKb
 ElWbXRHBtsw8dxmDM4SM1qg5Ju7nfHjnDXpBHqE7nNz/u6rFCTat6aFFJYwBbIkWOj1a
 lDsEL1VHoZr+6MCxJ4SBe7gPVCCCIASzA1DQeGkerHkpAGky8eMYzs2EVLKI2uK1QfG2
 hrp5N4dqFdDWi5juwnchTU9oxjvTurxOE8pKdeDBxeYcbHFpYJBqAGJ11N8dmND51hL5 7Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfm5nkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 19:44:41 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 11O0ht0d147073;
        Tue, 23 Feb 2021 19:43:55 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36vkfm5njp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Feb 2021 19:43:55 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11O0RwxR017511;
        Wed, 24 Feb 2021 00:43:53 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma02fra.de.ibm.com with ESMTP id 36tt289m58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 00:43:53 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11O0houY36110818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 00:43:50 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B816F42041;
        Wed, 24 Feb 2021 00:43:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 161C242042;
        Wed, 24 Feb 2021 00:43:48 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.65.43])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Feb 2021 00:43:47 +0000 (GMT)
Message-ID: <0a25f4b7ed53566b13211d5aeea18e7f13f12bd7.camel@linux.ibm.com>
Subject: Re: [PATCH v3 0/2]     IMA: Add test for dm-crypt measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>, agk@redhat.com,
        snitzer@redhat.com, gmazyland@gmail.com,
        linux-integrity@vger.kernel.org, dm-devel@redhat.com
Date:   Tue, 23 Feb 2021 19:43:46 -0500
In-Reply-To: <20210223225930.27095-1-pvorel@suse.cz>
References: <20210223225930.27095-1-pvorel@suse.cz>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_12:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 suspectscore=0 phishscore=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240001
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Tue, 2021-02-23 at 23:59 +0100, Petr Vorel wrote:
> Hi!
> 
> I updated Tushar's patchset to speedup things.
> 
> Changes v2->v3
> * rename function s/check_ima_ascii_log_for_policy/test_policy_measurement/
> * move tst_res TPASS/TFAIL into test_policy_measurement()
> * drop template=ima-buf (see Lakshmi's patch [1] and discussion about
>   it, it will be removed from ima_keys.sh as well)
> * moved ima_dm_crypt.sh specific changes to second commit
> * further API and style related cleanup
> 
> Could you please check this patchset?

I'm not sure about the status of the associated IMA dm-crypt kernel
patch set.  It hasn't even been reviewed, definitely not upstreamed.  
 I would hold off on upstreaming the associated ltp test.

thanks,

Mimi

