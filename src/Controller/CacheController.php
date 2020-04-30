<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Contracts\Cache\CacheInterface;
use Symfony\Contracts\Cache\ItemInterface;

class CacheController extends AbstractController
{

    /**
     * @var CacheInterface
     */
    private $cache;

    public function __construct(CacheInterface $cache)
    {
        $this->cache = $cache;
    }

    /**
     * @Route("/cache", name="cache")
     */
    public function index()
    {
        $value = $this->cache->get('test_key', function(ItemInterface $item){
            $item->expiresAfter(5);
            return [
                'value' => rand(0,100),
                'metadata' => $item->getMetadata()
            ];
        });

        return $this->json([
            'message' => 'Cache controller',
            'value' => $value
        ]);
    }
}
